param(
    [string]$Repo = "OS2sofd/issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,
    [string]$TargetStatus = "Klar til prioritering",
    [string]$TeamMention = "@OS2sofd/koordinationsgruppe",
    [string]$StatePath = "data/notifikation-klar-til-bestilling.json"
)

$ErrorActionPreference = "Stop"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom

function Run-GhJson {
    param([string[]]$GhArgs)

    $errFile = Join-Path ([System.IO.Path]::GetTempPath()) ("os2sofd-gh-err-" + [guid]::NewGuid().ToString() + ".txt")

    try {
        $output = & gh @GhArgs 2> $errFile
        $exitCode = $LASTEXITCODE

        if ($exitCode -ne 0) {
            $errText = ""
            if (Test-Path $errFile) {
                $errText = Get-Content $errFile -Raw -ErrorAction SilentlyContinue
            }
            throw "GitHub CLI fejl ved: gh $($GhArgs -join ' ')`n$errText"
        }

        if (-not $output) { return $null }
        return ((($output -join "`n").Trim()) | ConvertFrom-Json)
    }
    finally {
        Remove-Item $errFile -ErrorAction SilentlyContinue
    }
}

function Get-PropertyValue {
    param(
        [object]$Object,
        [string[]]$Names
    )

    foreach ($name in $Names) {
        $prop = $Object.PSObject.Properties |
            Where-Object { $_.Name -ieq $name } |
            Select-Object -First 1

        if ($null -ne $prop -and $null -ne $prop.Value) {
            return [string]$prop.Value
        }
    }

    return ""
}

function Get-Status {
    param([object]$Item)
    return Get-PropertyValue $Item @("status","Status")
}

function Get-StateEntry {
    param(
        [object]$State,
        [int]$Number
    )

    $key = "issue-" + [string]$Number

    $prop = $State.issues.PSObject.Properties |
        Where-Object { $_.Name -eq $key } |
        Select-Object -First 1

    if ($null -eq $prop) { return $null }
    return $prop.Value
}

function Set-StateEntry {
    param(
        [object]$State,
        [int]$Number,
        [object]$Entry
    )

    $key = "issue-" + [string]$Number

    $prop = $State.issues.PSObject.Properties |
        Where-Object { $_.Name -eq $key } |
        Select-Object -First 1

    if ($null -eq $prop) {
        $State.issues | Add-Member -NotePropertyName $key -NotePropertyValue $Entry
    }
    else {
        $prop.Value = $Entry
    }
}

function Load-State {
    param([string]$Path)

    if (Test-Path $Path) {
        $state = Get-Content $Path -Raw | ConvertFrom-Json

        if ($null -eq $state.issues) {
            $state | Add-Member -NotePropertyName issues -NotePropertyValue ([PSCustomObject]@{})
        }

        if ($null -eq $state.schemaVersion) {
            $state | Add-Member -NotePropertyName schemaVersion -NotePropertyValue 2
        }
        else {
            $state.schemaVersion = 2
        }

        return $state
    }

    return [PSCustomObject]@{
        schemaVersion = 2
        initialized   = $false
        updatedAt     = $null
        issues        = [PSCustomObject]@{}
    }
}

function Save-State {
    param(
        [object]$State,
        [string]$Path
    )

    $State.updatedAt = (Get-Date).ToString("o")

    $parent = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($parent) -and -not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    $json = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $Utf8NoBom)
}

function Add-IssueComment {
    param(
        [int]$Number,
        [string]$Body
    )

    if ([string]::IsNullOrWhiteSpace($env:REPO_TOKEN)) {
        throw "REPO_TOKEN mangler. Workflowet skal stille PAT/token til rådighed som REPO_TOKEN."
    }

    $uri = "https://api.github.com/repos/$Repo/issues/$Number/comments"

    $headers = @{
        Authorization          = "Bearer $env:REPO_TOKEN"
        Accept                 = "application/vnd.github+json"
        "X-GitHub-Api-Version" = "2022-11-28"
        "User-Agent"           = "OS2sofd-klar-til-prioritering"
    }

    $payload = @{
        body = $Body
    } | ConvertTo-Json

    Invoke-RestMethod `
        -Method Post `
        -Uri $uri `
        -Headers $headers `
        -ContentType "application/json; charset=utf-8" `
        -Body ([System.Text.Encoding]::UTF8.GetBytes($payload)) | Out-Null
}

function Get-IssueComments {
    param([int]$Number)

    $comments = Run-GhJson @(
        "api",
        "repos/$Repo/issues/$Number/comments?per_page=100"
    )

    return @($comments)
}

function Test-ExistingKgNotification {
    param([object[]]$Comments)

    foreach ($comment in @($Comments)) {
        $body = [string]$comment.body

        if ($body -match 'os2sofd-klar-til-bestilling') {
            return $true
        }

        # Også manuelle notifikationer tæller, hvis de tydeligt nævner
        # koordinationsgruppen og målstatus.
        if (
            $body -match '(?i)@OS2sofd/koordinationsgruppe' -and
            $body -match '(?i)Klar til prioritering'
        ) {
            return $true
        }
    }

    return $false
}

function Get-LatestPoReview {
    param(
        [object[]]$Comments,
        [int]$IssueNumber
    )

    $pattern = '<!--\s*os2sofd-loesningsreview-v1\s+issue:(\d+)\s+review:(\d+)\s+reviewed-through-comment:(\d+)\s*-->'
    $reviews = @()

    foreach ($comment in @($Comments)) {
        $body = [string]$comment.body
        $match = [regex]::Match($body, $pattern)

        if ($match.Success -and [int]$match.Groups[1].Value -eq $IssueNumber) {
            $signal = ""

            $overallMatch = [regex]::Match(
                $body,
                '(?ms)###\s*Samlet PO-review\s*\r?\n+\s*(?<signal>🟢|🟡|🔴)'
            )

            if ($overallMatch.Success) {
                $signal = $overallMatch.Groups["signal"].Value
            }

            $reviews += [PSCustomObject]@{
                ReviewNumber = [int]$match.Groups[2].Value
                Signal       = $signal
                CommentId    = [long]$comment.id
            }
        }
    }

    if ($reviews.Count -eq 0) {
        return [PSCustomObject]@{
            HasReview    = $false
            ReviewNumber = 0
            Signal       = ""
            ReadyForKg   = $false
        }
    }

    $latest = @(
        $reviews | Sort-Object ReviewNumber -Descending
    ) | Select-Object -First 1

    return [PSCustomObject]@{
        HasReview    = $true
        ReviewNumber = [int]$latest.ReviewNumber
        Signal       = [string]$latest.Signal
        ReadyForKg   = ([string]$latest.Signal -in @("🟢","🟡"))
    }
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) blev ikke fundet."
}

$state = Load-State $StatePath
$isFirstRun = -not [bool]$state.initialized
$stateChanged = $isFirstRun

Write-Host ""
Write-Host "OS2sofd - notifikation ved '$TargetStatus'" -ForegroundColor Cyan
Write-Host "Project: $ProjectOwner / #$ProjectNumber"
Write-Host "Team: $TeamMention"
Write-Host "Krav før notifikation: Estimat + PO-review (🟢/🟡)"
Write-Host ""

$project = Run-GhJson @(
    "project", "item-list", "$ProjectNumber",
    "--owner", $ProjectOwner,
    "--limit", "500",
    "--format", "json"
)

$items = @(
    $project.items |
    Where-Object {
        $_.content.repository -eq $Repo -and
        $null -ne $_.content.number
    }
)

Write-Host "Fundet $($items.Count) issues i Project."

$notifications = 0
$nowIso = (Get-Date).ToString("o")

foreach ($item in $items) {
    $number = [int]$item.content.number
    $title = [string]$item.content.title
    $url = [string]$item.content.url
    $status = Get-Status $item
    $estimate = Get-PropertyValue $item @("Estimat","estimat")

    $previous = Get-StateEntry $state $number
    $previousStatus = ""
    $previousNotificationSent = $false
    $previousNotificationSentAt = $null

    if ($null -ne $previous) {
        $previousStatus = [string]$previous.status

        $notificationProp = $previous.PSObject.Properties |
            Where-Object { $_.Name -eq "notificationSent" } |
            Select-Object -First 1

        if ($null -ne $notificationProp) {
            $previousNotificationSent = [bool]$notificationProp.Value
        }

        $notificationAtProp = $previous.PSObject.Properties |
            Where-Object { $_.Name -eq "notificationSentAt" } |
            Select-Object -First 1

        if ($null -ne $notificationAtProp) {
            $previousNotificationSentAt = $notificationAtProp.Value
        }
    }

    $notificationSent = $previousNotificationSent
    $notificationSentAt = $previousNotificationSentAt
    $reviewNumber = 0
    $reviewSignal = ""
    $readyForNotification = $false

    if ($status -eq $TargetStatus -and -not $notificationSent) {
        $comments = Get-IssueComments -Number $number

        # Bagudkompatibilitet: tidligere automatisk eller manuel KG-notifikation
        # skal forhindre dubletter, også selv om gammel state-fil ikke havde feltet.
        if (Test-ExistingKgNotification -Comments $comments) {
            $notificationSent = $true

            if ($null -eq $notificationSentAt) {
                $notificationSentAt = "existing-comment"
            }

            Write-Host "Issue #${number}: koordinationsgruppen er allerede notificeret." -ForegroundColor DarkGray
        }
        else {
            $review = Get-LatestPoReview -Comments $comments -IssueNumber $number
            $reviewNumber = [int]$review.ReviewNumber
            $reviewSignal = [string]$review.Signal

            $hasEstimate = -not [string]::IsNullOrWhiteSpace($estimate)
            $readyForNotification = ($hasEstimate -and $review.ReadyForKg)

            if (-not $hasEstimate) {
                Write-Host "Issue #${number}: afventer Estimat." -ForegroundColor DarkGray
            }
            elseif (-not $review.HasReview) {
                Write-Host "Issue #${number}: afventer PO-review." -ForegroundColor DarkGray
            }
            elseif ($review.Signal -eq "🔴") {
                Write-Host "Issue #${number}: PO-review er rødt og kræver afklaring før KG-notifikation." -ForegroundColor Yellow
            }
            elseif ([string]::IsNullOrWhiteSpace($review.Signal)) {
                Write-Host "Issue #${number}: PO-review fundet, men samlet reviewsignal kunne ikke aflæses." -ForegroundColor Yellow
            }
        }
    }

    $shouldNotify = (
        -not $isFirstRun -and
        $status -eq $TargetStatus -and
        -not $notificationSent -and
        $readyForNotification
    )

    if ($shouldNotify) {
        $comment = @"
$TeamMention

Dette ændringsønske er i **$TargetStatus** og er nu klar til koordinationsgruppens behandling.

PO-review af løsningsbeskrivelsen er gennemført, og estimat er registreret.

_Automatisk notifikation._
<!-- os2sofd-klar-til-bestilling -->
"@

        Write-Host "Notificerer på issue #${number}: $title" -ForegroundColor Yellow
        Add-IssueComment -Number $number -Body $comment

        $notificationSent = $true
        $notificationSentAt = $nowIso
        $notifications++
    }

    # Ved første kørsel bruges aktuelle, allerede kvalificerede sager som baseline,
    # så en helt ny state-fil ikke udløser historiske notifikationer på næste kørsel.
    # Sager som endnu mangler review/estimat forbliver derimod ikke markeret som sendt;
    # de kan notificeres senere, når kravene bliver opfyldt.
    if ($isFirstRun -and $status -eq $TargetStatus -and $readyForNotification -and -not $notificationSent) {
        $notificationSent = $true
        $notificationSentAt = "baseline"
        Write-Host "Issue #${number}: kvalificeret ved første baseline-kørsel; historisk notifikation undertrykkes." -ForegroundColor DarkGray
    }

    $stateNeedsUpdate = (
        $null -eq $previous -or
        $previousStatus -ne $status -or
        $previousNotificationSent -ne $notificationSent -or
        [string]$previousNotificationSentAt -ne [string]$notificationSentAt
    )

    if ($stateNeedsUpdate) {
        $entry = [PSCustomObject]@{
            number             = $number
            title              = $title
            url                = $url
            status             = $status
            notificationSent   = $notificationSent
            notificationSentAt = $notificationSentAt
            lastObserved       = $nowIso
        }

        Set-StateEntry $state $number $entry
        $stateChanged = $true
    }
}

if ($isFirstRun) {
    Write-Host "Første kørsel: nuværende status er registreret som baseline. Ingen historiske notifikationer sendt." -ForegroundColor Cyan
}

$state.initialized = $true

if ($stateChanged) {
    Save-State $state $StatePath
    Write-Host "State er opdateret: $StatePath" -ForegroundColor Cyan
}
else {
    Write-Host "Ingen relevante ændringer. State-filen ændres ikke." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "Færdig. Sendte notifikationer: $notifications" -ForegroundColor Green
