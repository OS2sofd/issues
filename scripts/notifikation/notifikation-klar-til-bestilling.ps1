param(
    [string]$Repo = "OS2sofd/issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,
    [string]$TargetStatus = "Klar til bestilling",
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

function Get-Status {
    param([object]$Item)

    $prop = $Item.PSObject.Properties |
        Where-Object { $_.Name -ieq "status" } |
        Select-Object -First 1

    if ($null -eq $prop -or $null -eq $prop.Value) {
        return ""
    }

    return [string]$prop.Value
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

        return $state
    }

    return [PSCustomObject]@{
        schemaVersion = 1
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
        throw "REPO_TOKEN mangler. Workflowet skal stille github.token til rådighed som REPO_TOKEN."
    }

    $uri = "https://api.github.com/repos/$Repo/issues/$Number/comments"

    $headers = @{
        Authorization         = "Bearer $env:REPO_TOKEN"
        Accept                = "application/vnd.github+json"
        "X-GitHub-Api-Version" = "2022-11-28"
        "User-Agent"          = "OS2sofd-klar-til-bestilling"
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

    $previous = Get-StateEntry $state $number
    $previousStatus = ""

    if ($null -ne $previous) {
        $previousStatus = [string]$previous.status
    }

    $shouldNotify = $false

    if (-not $isFirstRun) {
        if ($null -eq $previous) {
            # Et nyt Project-item, som første gang observeres direkte i målstatus.
            if ($status -eq $TargetStatus) {
                $shouldNotify = $true
            }
        }
        elseif ($previousStatus -ne $TargetStatus -and $status -eq $TargetStatus) {
            # Almindeligt statusskift ind i målstatus.
            $shouldNotify = $true
        }
    }

    if ($shouldNotify) {
        $comment = @"
$TeamMention

Dette ændringsønske er nu flyttet til **$TargetStatus** og er klar til koordinationsgruppens behandling.

_Automatisk notifikation._
<!-- os2sofd-klar-til-bestilling -->
"@

        Write-Host "Notificerer på issue #${number}: $title" -ForegroundColor Yellow
        Add-IssueComment -Number $number -Body $comment
        $notifications++
    }

    # Gem kun state, når et issue er nyt eller status faktisk har ændret sig.
    # Dermed undgår vi et Git-commit hver time uden reelle ændringer.
    if ($null -eq $previous -or $previousStatus -ne $status) {
        $entry = [PSCustomObject]@{
            number       = $number
            title        = $title
            url          = $url
            status       = $status
            lastObserved = $nowIso
        }

        Set-StateEntry $state $number $entry
        $stateChanged = $true
    }
}

if ($isFirstRun) {
    Write-Host "Første kørsel: nuværende status er registreret som baseline. Ingen notifikationer sendt." -ForegroundColor Cyan
}

$state.initialized = $true

if ($stateChanged) {
    Save-State $state $StatePath
    Write-Host "State er opdateret: $StatePath" -ForegroundColor Cyan
}
else {
    Write-Host "Ingen statusændringer. State-filen ændres ikke." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "Færdig. Sendte notifikationer: $notifications" -ForegroundColor Green
