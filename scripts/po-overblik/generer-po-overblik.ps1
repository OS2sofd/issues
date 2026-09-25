param(
    [string]$Repo = "OS2sofd/issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,

    # Første testversion skriver lokalt. I GitHub Actions ændres dette senere til docs/po-overblik.md.
    [string]$OutputPath = (Join-Path $env:USERPROFILE "Downloads\po-overblik.md"),

    # Historikfil. I GitHub Actions angives denne som data/po-overblik-history.json.
    [string]$HistoryPath = (Join-Path $env:USERPROFILE "Downloads\po-overblik-history.json"),

    # Kan fx angives som "Q3 2026". Hvis tom, udledes aktuelt kvartal automatisk.
    [string]$CurrentRelease = "",

    [int]$HighPriorityInactiveDays = 14,
    [int]$SolutionDescriptionInactiveDays = 14,
    [int]$CommunicationAgeDays = 90,
    [int]$CommunicationInactiveDays = 30,
    [int]$TestReviewInactiveDays = 14
)

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom
$ErrorActionPreference = "Stop"

# ---------------------------
# Hjælpefunktioner
# ---------------------------

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

    if ($null -eq $Object) { return "" }

    foreach ($name in $Names) {
        $prop = $Object.PSObject.Properties | Where-Object {
            $_.Name -ieq $name
        } | Select-Object -First 1

        if ($null -ne $prop -and $null -ne $prop.Value) {
            if ($prop.Value -is [System.Array]) {
                return (($prop.Value | ForEach-Object { [string]$_ }) -join ", ")
            }
            return [string]$prop.Value
        }
    }

    return ""
}

function Get-PropertyRaw {
    param(
        [object]$Object,
        [string[]]$Names
    )

    if ($null -eq $Object) { return $null }

    foreach ($name in $Names) {
        $prop = $Object.PSObject.Properties | Where-Object {
            $_.Name -ieq $name
        } | Select-Object -First 1

        if ($null -ne $prop) {
            return $prop.Value
        }
    }

    return $null
}

function Get-ReleaseInfo {
    param([object]$ProjectItem)

    $raw = Get-PropertyRaw $ProjectItem @("Planlagt release","planlagt release","plannedRelease")

    if ($null -eq $raw) {
        return [PSCustomObject]@{
            Title = ""
            Start = $null
            End   = $null
        }
    }

    if ($raw -is [string]) {
        return [PSCustomObject]@{
            Title = [string]$raw
            Start = $null
            End   = $null
        }
    }

    $title = Get-PropertyValue $raw @("title","Title")
    $start = $null
    $end = $null

    $startText = Get-PropertyValue $raw @("startDate","StartDate")
    $durationText = Get-PropertyValue $raw @("duration","Duration")

    if (-not [string]::IsNullOrWhiteSpace($startText)) {
        try {
            $start = [DateTime]::Parse($startText)

            if (-not [string]::IsNullOrWhiteSpace($durationText)) {
                $duration = [int]$durationText
                $end = $start.AddDays($duration)
            }
        }
        catch {
            $start = $null
            $end = $null
        }
    }

    return [PSCustomObject]@{
        Title = $title
        Start = $start
        End   = $end
    }
}


function Get-ProjectDate {
    param(
        [object]$ProjectItem,
        [string[]]$Names
    )

    $raw = Get-PropertyRaw $ProjectItem $Names
    if ($null -eq $raw) { return $null }

    $value = [string]$raw
    if ([string]::IsNullOrWhiteSpace($value)) { return $null }

    try {
        return [DateTime]::Parse($value)
    }
    catch {
        return $null
    }
}

function Escape-Md {
    param([string]$Text)

    if ([string]::IsNullOrWhiteSpace($Text)) { return "–" }

    $value = $Text -replace '\|','\|' -replace "`r?`n",' '
    return $value.Trim()
}

function Issue-Link {
    param(
        [int]$Number,
        [string]$Title,
        [string]$Url
    )

    return "[#$Number – $(Escape-Md $Title)]($Url)"
}

function Issue-Refs {
    param([object[]]$Rows)

    $refs = @(
        @($Rows) |
        Sort-Object PriorityRank, @{Expression={$_.AgeDays};Descending=$true}, Number |
        ForEach-Object { "[#$($_.Number)]($($_.Url))" }
    )

    if ($refs.Count -eq 0) { return "–" }
    return ($refs -join ", ")
}

function Priority-Rank {
    param([string]$Priority)

    switch -Regex ($Priority) {
        '^Kritisk$' { return 1 }
        '^Høj$'     { return 2 }
        '^Mellem$'  { return 3 }
        '^Lav$'     { return 4 }
        default     { return 9 }
    }
}

function Age-Signal {
    param([int]$Days)

    if ($Days -gt 183) { return "🔴" }
    if ($Days -ge 137) { return "🟠" }
    if ($Days -ge 91)  { return "🟡" }
    return "🟢"
}

function Age-Text {
    param([int]$Days)

    $months = [math]::Round($Days / 30.44, 1)
    return "$Days dage / $months mdr."
}

function Median {
    param([double[]]$Values)

    if ($null -eq $Values -or $Values.Count -eq 0) { return 0 }

    $sorted = @($Values | Sort-Object)
    $count = $sorted.Count

    if ($count % 2 -eq 1) {
        return [double]$sorted[[int][math]::Floor($count / 2)]
    }

    return ([double]$sorted[$count / 2 - 1] + [double]$sorted[$count / 2]) / 2
}

function Is-TerminalStatus {
    param([string]$Status)
    return ($Status -in @("Afsluttede løsninger","Won't fix"))
}

function Is-CompletedStatus {
    param([string]$Status)
    return ($Status -eq "Afsluttede løsninger")
}

function Is-ActiveStatus {
    param([string]$Status)
    return -not (Is-TerminalStatus $Status)
}

function Get-CurrentReleaseName {
    if (-not [string]::IsNullOrWhiteSpace($CurrentRelease)) {
        return $CurrentRelease
    }

    $now = Get-Date
    $quarter = [math]::Ceiling($now.Month / 3)
    return "$quarter. kvartal $($now.Year)"
}


function Get-IssueHistoryEntry {
    param(
        [object]$History,
        [int]$Number
    )

    if ($null -eq $History.issues) { return $null }

    $prop = $History.issues.PSObject.Properties |
        Where-Object { $_.Name -eq ("issue-" + [string]$Number) } |
        Select-Object -First 1

    if ($null -eq $prop) { return $null }
    return $prop.Value
}

function Set-IssueHistoryEntry {
    param(
        [object]$History,
        [int]$Number,
        [object]$Entry
    )

    $name = "issue-" + [string]$Number
    $prop = $History.issues.PSObject.Properties |
        Where-Object { $_.Name -eq $name } |
        Select-Object -First 1

    if ($null -eq $prop) {
        $History.issues | Add-Member -NotePropertyName $name -NotePropertyValue $Entry
    }
    else {
        $prop.Value = $Entry
    }
}

function Load-History {
    param([string]$Path)

    if (Test-Path $Path) {
        try {
            $loaded = Get-Content $Path -Raw | ConvertFrom-Json

            if ($null -eq $loaded.issues) {
                $loaded | Add-Member -NotePropertyName issues -NotePropertyValue ([PSCustomObject]@{})
            }

            return $loaded
        }
        catch {
            throw "Historikfilen kunne ikke læses: $Path`n$($_.Exception.Message)"
        }
    }

    return [PSCustomObject]@{
        schemaVersion = 1
        startedAt     = (Get-Date).ToString("o")
        updatedAt     = (Get-Date).ToString("o")
        issues        = [PSCustomObject]@{}
    }
}

function Save-History {
    param(
        [object]$History,
        [string]$Path
    )

    $History.updatedAt = (Get-Date).ToString("o")

    $parent = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($parent) -and -not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    $json = $History | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $Utf8NoBom)
}

function Format-StatusAge {
    param(
        [int]$Days,
        [bool]$IsBaseline
    )

    $value = Age-Text $Days

    if ($IsBaseline) {
        return "≥ $value"
    }

    return $value
}


function Get-PoReviewInfo {
    param(
        [object[]]$Comments,
        [int]$IssueNumber
    )

    $reviewPattern = '<!--\s*os2sofd-loesningsreview-v1\s+issue:(\d+)\s+review:(\d+)\s+reviewed-through-comment:(\d+)\s*-->'
    $reviews = @()

    foreach ($comment in @($Comments)) {
        $body = [string]$comment.body
        $match = [regex]::Match($body, $reviewPattern)

        if ($match.Success -and [int]$match.Groups[1].Value -eq $IssueNumber) {
            $reviews += [PSCustomObject]@{
                CommentId               = [long]$comment.id
                ReviewNumber            = [int]$match.Groups[2].Value
                ReviewedThroughCommentId = [long]$match.Groups[3].Value
                CreatedAt               = [string]$comment.created_at
                Body                    = $body
            }
        }
    }

    if ($reviews.Count -eq 0) {
        return [PSCustomObject]@{
            HasReview                = $false
            ReviewNumber             = 0
            ReviewSignal             = ""
            ReviewText               = ""
            ReviewAttention          = ""
            ReviewCommentId          = 0
            ReviewedThroughCommentId = 0
            NewCommentsSinceReview   = 0
        }
    }

    $latest = @(
        $reviews |
        Sort-Object ReviewNumber -Descending
    ) | Select-Object -First 1

    $reviewSignal = ""
    $reviewText = ""

    $overallMatch = [regex]::Match(
        [string]$latest.Body,
        '(?ms)###\s*Samlet PO-review\s*\r?\n+\s*(?<signal>🟢|🟡|🔴)\s*\*\*(?<text>.*?)\*\*'
    )

    if ($overallMatch.Success) {
        $reviewSignal = $overallMatch.Groups["signal"].Value
        $reviewText = $overallMatch.Groups["text"].Value.Trim()
    }

    $reviewAttention = ""
    $attentionMatch = [regex]::Match(
        [string]$latest.Body,
        '(?ms)###\s*Opmærksomhed\s*\r?\n+(?<content>.*?)(?=\r?\n###\s|\z)'
    )

    if ($attentionMatch.Success) {
        $attentionLines = @(
            $attentionMatch.Groups["content"].Value -split "`r?`n" |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ -match '^-\s+' } |
            ForEach-Object { $_ -replace '^-\s+', '' }
        )

        if ($attentionLines.Count -gt 0) {
            $reviewAttention = ($attentionLines -join "; ")
        }
    }

    # Kommentarer efter det grundlag, som seneste review dækkede.
    # Kendte automatiske proceskommentarer tælles ikke som nyt reviewgrundlag.
    $newComments = @(
        $Comments |
        Where-Object {
            [long]$_.id -gt [long]$latest.ReviewedThroughCommentId -and
            [string]$_.body -notmatch 'os2sofd-loesningsreview-v1' -and
            [string]$_.body -notmatch 'os2sofd-klar-til-bestilling' -and
            [string]$_.body -notmatch 'os2sofd-screening-v3'
        }
    )

    return [PSCustomObject]@{
        HasReview                = $true
        ReviewNumber             = [int]$latest.ReviewNumber
        ReviewSignal             = $reviewSignal
        ReviewText               = $reviewText
        ReviewAttention          = $reviewAttention
        ReviewCommentId          = [long]$latest.CommentId
        ReviewedThroughCommentId = [long]$latest.ReviewedThroughCommentId
        NewCommentsSinceReview   = @($newComments).Count
    }
}

# ---------------------------
# Forudsætninger
# ---------------------------

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) blev ikke fundet."
}

& gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
    throw "GitHub CLI er ikke logget ind. Kør: gh auth login"
}

$tz = [System.TimeZoneInfo]::FindSystemTimeZoneById("Europe/Copenhagen")
$generatedAt = [System.TimeZoneInfo]::ConvertTimeFromUtc([DateTime]::UtcNow, $tz)
$currentReleaseName = Get-CurrentReleaseName

Write-Host ""
Write-Host "OS2sofd PO-overblik – produktion + historik" -ForegroundColor Cyan
Write-Host "Projekt: $ProjectOwner / Project #$ProjectNumber"
Write-Host "Aktuel release: $currentReleaseName"
Write-Host ""

# ---------------------------
# Hent Project-data
# ---------------------------

Write-Host "Henter Project-data..." -ForegroundColor Cyan

$project = Run-GhJson @(
    "project","item-list","$ProjectNumber",
    "--owner",$ProjectOwner,
    "--limit","500",
    "--format","json"
)

$projectItems = @(
    $project.items |
    Where-Object {
        $_.content.repository -eq $Repo -and
        $null -ne $_.content.number
    }
)

Write-Host "Fundet $($projectItems.Count) issues i Project."

# ---------------------------
# Hent issue-data + seneste kommentar
# ---------------------------

$rows = @()
$i = 0

foreach ($item in $projectItems) {
    $i++
    $n = [int]$item.content.number

    Write-Progress `
        -Activity "Henter GitHub-data" `
        -Status "Issue #$n ($i af $($projectItems.Count))" `
        -PercentComplete (($i / [math]::Max(1,$projectItems.Count)) * 100)

    $issue = Run-GhJson @("api","repos/$Repo/issues/$n")

    $commentCount = [int]$issue.comments
    $lastCommentAt = $null
    $lastCommentAuthor = ""
    $lastResponseAt = $null
    $lastResponseAuthor = ""
    $issueAuthor = [string]$issue.user.login
    $allComments = @()

    if ($commentCount -gt 0) {
        $pages = [math]::Ceiling($commentCount / 100)

        for ($page = 1; $page -le $pages; $page++) {
            $pageComments = @(Run-GhJson @(
                "api",
                "repos/$Repo/issues/$n/comments?per_page=100&page=$page"
            ))

            if ($pageComments.Count -gt 0) {
                $allComments += $pageComments
            }
        }

        if ($allComments.Count -gt 0) {
            $lastComment = $allComments[-1]
            if ($lastComment.created_at) {
                $lastCommentAt = [DateTimeOffset]::Parse([string]$lastComment.created_at).LocalDateTime
            }
            $lastCommentAuthor = [string]$lastComment.user.login

            # Kommunikationsproxy:
            # seneste kommentar fra en anden end den oprindelige opretter.
            $responses = @(
                $allComments | Where-Object {
                    [string]$_.user.login -ne $issueAuthor
                }
            )

            if ($responses.Count -gt 0) {
                $lastResponse = $responses[-1]
                if ($lastResponse.created_at) {
                    $lastResponseAt = [DateTimeOffset]::Parse([string]$lastResponse.created_at).LocalDateTime
                }
                $lastResponseAuthor = [string]$lastResponse.user.login
            }
        }
    }

    $reviewInfo = Get-PoReviewInfo -Comments $allComments -IssueNumber $n

    $createdAt = [DateTimeOffset]::Parse([string]$issue.created_at).LocalDateTime
    $updatedAt = [DateTimeOffset]::Parse([string]$issue.updated_at).LocalDateTime
    $closedAt = $null

    if ($issue.closed_at) {
        $closedAt = [DateTimeOffset]::Parse([string]$issue.closed_at).LocalDateTime
    }

    $ageDays = [math]::Floor(($generatedAt - $createdAt).TotalDays)
    $inactiveDays = [math]::Floor(($generatedAt - $updatedAt).TotalDays)

    $lastCommentDays = $null
    if ($null -ne $lastCommentAt) {
        $lastCommentDays = [math]::Floor(($generatedAt - $lastCommentAt).TotalDays)
    }

    $lastResponseDays = $null
    if ($null -ne $lastResponseAt) {
        $lastResponseDays = [math]::Floor(($generatedAt - $lastResponseAt).TotalDays)
    }

    $status = Get-PropertyValue $item @("status","Status")
    $priority = Get-PropertyValue $item @("Prioritet","prioritet")
    $estimate = Get-PropertyValue $item @("Estimat","estimat")
    $size = Get-PropertyValue $item @("Størrelse","størrelse")
    $releaseInfo = Get-ReleaseInfo $item
    $release = [string]$releaseInfo.Title
    $projectStartDate = Get-ProjectDate $item @("Start dato","start dato","Start date","startDate")
    $projectEndDate = Get-ProjectDate $item @("Slut dato","slut dato","End date","endDate")
    $municipality = Get-PropertyValue $item @("Kommune","kommune")
    $contact = Get-PropertyValue $item @("Kontakt","kontakt")
    $jira = Get-PropertyValue $item @("JIRA-Id","jira-id","JIRAId")

    $labels = @($issue.labels | ForEach-Object { [string]$_.name })
    $assignees = @($issue.assignees | ForEach-Object { [string]$_.login })

    $rows += [PSCustomObject]@{
        Number            = $n
        Title             = [string]$issue.title
        Url               = [string]$issue.html_url
        State             = [string]$issue.state
        Status            = $status
        Priority          = $priority
        PriorityRank      = Priority-Rank $priority
        Labels            = $labels -join ", "
        Municipality      = $municipality
        Contact           = $contact
        Assignees         = $assignees -join ", "
        Estimate          = $estimate
        Size              = $size
        Release           = $release
        ReleaseStart      = $releaseInfo.Start
        ReleaseEnd        = $releaseInfo.End
        ProjectStartDate  = $projectStartDate
        ProjectEndDate    = $projectEndDate
        Jira              = $jira
        IssueAuthor       = $issueAuthor
        CreatedAt         = $createdAt
        UpdatedAt         = $updatedAt
        ClosedAt          = $closedAt
        AgeDays           = [int]$ageDays
        InactiveDays      = [int]$inactiveDays
        LastCommentAt      = $lastCommentAt
        LastCommentDays    = $lastCommentDays
        LastCommentAuthor  = $lastCommentAuthor
        LastResponseAt     = $lastResponseAt
        LastResponseDays   = $lastResponseDays
        LastResponseAuthor = $lastResponseAuthor
        HasPoReview         = [bool]$reviewInfo.HasReview
        PoReviewNumber      = [int]$reviewInfo.ReviewNumber
        PoReviewSignal      = [string]$reviewInfo.ReviewSignal
        PoReviewText        = [string]$reviewInfo.ReviewText
        PoReviewAttention   = [string]$reviewInfo.ReviewAttention
        PoReviewCommentId   = [long]$reviewInfo.ReviewCommentId
        ReviewedThroughCommentId = [long]$reviewInfo.ReviewedThroughCommentId
        NewCommentsSincePoReview = [int]$reviewInfo.NewCommentsSinceReview
    }
}

Write-Progress -Activity "Henter GitHub-data" -Completed

# ---------------------------
# Status-historik
# ---------------------------

Write-Host "Opdaterer status-historik..." -ForegroundColor Cyan

$history = Load-History $HistoryPath

foreach ($r in $rows) {
    $nowIso = $generatedAt.ToString("o")
    $entry = Get-IssueHistoryEntry $history $r.Number

    if ($null -eq $entry) {
        # Første observation er baseline. Vi ved ikke, hvornår den eksisterende status reelt begyndte.
        $entry = [PSCustomObject]@{
            number                  = $r.Number
            title                   = $r.Title
            url                     = $r.Url
            firstObservedAt         = $nowIso
            lastObservedAt          = $nowIso
            currentStatus           = $r.Status
            currentStatusSince      = $nowIso
            currentStatusIsBaseline = $true
            transitions             = @(
                [PSCustomObject]@{
                    status     = $r.Status
                    observedAt = $nowIso
                    kind       = "baseline"
                }
            )
        }

        Set-IssueHistoryEntry $history $r.Number $entry
    }
    else {
        $entry.title = $r.Title
        $entry.url = $r.Url
        $entry.lastObservedAt = $nowIso

        if ([string]$entry.currentStatus -ne [string]$r.Status) {
            $transitions = @($entry.transitions)
            $transitions += [PSCustomObject]@{
                status     = $r.Status
                observedAt = $nowIso
                kind       = "status-change"
            }

            $entry.transitions = $transitions
            $entry.currentStatus = $r.Status
            $entry.currentStatusSince = $nowIso
            $entry.currentStatusIsBaseline = $false
        }

        Set-IssueHistoryEntry $history $r.Number $entry
    }

    try {
        $statusSince = [DateTimeOffset]::Parse([string]$entry.currentStatusSince).LocalDateTime
    }
    catch {
        $statusSince = $generatedAt
    }

    $statusAgeDays = [math]::Max(
        0,
        [math]::Floor(($generatedAt - $statusSince).TotalDays)
    )

    $r | Add-Member -NotePropertyName StatusSince -NotePropertyValue $statusSince -Force
    $r | Add-Member -NotePropertyName StatusAgeDays -NotePropertyValue ([int]$statusAgeDays) -Force
    $r | Add-Member -NotePropertyName StatusAgeIsBaseline -NotePropertyValue ([bool]$entry.currentStatusIsBaseline) -Force
}

Save-History $history $HistoryPath

# ---------------------------
# Analyse
# ---------------------------

$statusOrder = @(
    "Nye ændringsønsker",
    "Screening",
    "Afventer løsningsbeskrivelse",
    "Klar til prioritering",
    "Bestilt hos leverandør",
    "Igangværende opgaver",
    "Løsninger i test",
    "Løsninger i review",
    "Afsluttede løsninger",
    "Won't fix"
)

$active = @($rows | Where-Object { Is-ActiveStatus $_.Status })
$completed = @($rows | Where-Object { Is-CompletedStatus $_.Status })
$wontFix = @($rows | Where-Object { $_.Status -eq "Won't fix" })
$activeWithJiraReference = @($active | Where-Object { -not [string]::IsNullOrWhiteSpace($_.Jira) })

$attention = @{}

function Add-Attention {
    param(
        [object]$Row,
        [string]$Signal,
        [string]$Reason
    )

    $key = [string]$Row.Number

    if (-not $attention.ContainsKey($key)) {
        $attention[$key] = [PSCustomObject]@{
            Row = $Row
            Signals = @()
            Reasons = @()
        }
    }

    if ($attention[$key].Signals -notcontains $Signal) {
        $attention[$key].Signals += $Signal
    }

    if ($attention[$key].Reasons -notcontains $Reason) {
        $attention[$key].Reasons += $Reason
    }
}

foreach ($r in $active) {
    # Alder er et strategisk signal, men ikke i sig selv en PO-handling.
    # Det vises i backlog-/omløbstidsdelen og løftes kun, hvis der samtidig
    # er et konkret handlingssignal.

    if (($r.Priority -eq "Kritisk" -or $r.Priority -eq "Høj") -and $r.InactiveDays -ge $HighPriorityInactiveDays) {
        Add-Attention $r "🔴" "$($r.Priority)-prioritet uden registreret opdatering i $($r.InactiveDays) dage"
    }

    if ($r.Status -eq "Afventer løsningsbeskrivelse" -and $r.InactiveDays -ge $SolutionDescriptionInactiveDays) {
        Add-Attention $r "🟡" "Afventer løsningsbeskrivelse uden registreret opdatering i $($r.InactiveDays) dage"
    }

    if ($r.Status -eq "Klar til prioritering") {
        # Selve status er ikke et opmærksomhedssignal.
        # Kun mangler, røde reviews og nye kommentarer løftes.
        if ([string]::IsNullOrWhiteSpace($r.Priority)) {
            Add-Attention $r "🔴" "Klar til prioritering, men mangler prioritet"
        }

        if ([string]::IsNullOrWhiteSpace($r.Estimate)) {
            Add-Attention $r "🔴" "Klar til prioritering, men mangler estimat"
        }

        if (-not $r.HasPoReview) {
            Add-Attention $r "🔴" "Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen"
        }
        elseif ($r.PoReviewSignal -eq "🔴") {
            Add-Attention $r "🔴" "PO-review kræver afklaring før prioritering"
        }

        if ($r.HasPoReview -and $r.NewCommentsSincePoReview -gt 0) {
            Add-Attention $r "⚠️" "$($r.NewCommentsSincePoReview) ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes"
        }
    }

    if (
        $r.Status -in @("Bestilt hos leverandør","Igangværende opgaver") -and
        [string]::IsNullOrWhiteSpace($r.Release)
    ) {
        Add-Attention $r "🟡" "$($r.Status), men mangler planlagt release"
    }

    if (
        $r.Status -in @("Bestilt hos leverandør","Igangværende opgaver") -and
        [string]::IsNullOrWhiteSpace($r.Assignees)
    ) {
        Add-Attention $r "🟡" "$($r.Status), men mangler assignee"
    }

    if (
        $r.Status -in @("Løsninger i test","Løsninger i review") -and
        $r.InactiveDays -ge $TestReviewInactiveDays
    ) {
        Add-Attention $r "🟡" "$($r.Status) uden registreret opdatering i $($r.InactiveDays) dage"
    }

    if (
        $null -ne $r.ReleaseEnd -and
        $r.ReleaseEnd.Date -lt $generatedAt.Date
    ) {
        Add-Attention $r "🔴" "Planlagt release '$($r.Release)' er udløbet"
    }

    if (
        $r.Release -eq $currentReleaseName -and
        $r.Status -in @("Nye ændringsønsker","Screening","Afventer løsningsbeskrivelse","Klar til prioritering","Bestilt hos leverandør")
    ) {
        Add-Attention $r "🟡" "Planlagt til $currentReleaseName, men endnu ikke igangværende"
    }

    # Kommunikationsproxy:
    # For ældre aktive issues ser vi efter seneste kommentar fra en anden end opretter.
    if ($r.AgeDays -ge $CommunicationAgeDays) {
        if ($null -eq $r.LastResponseAt) {
            Add-Attention $r "⚠️" "Kommunikation bør vurderes: ingen registreret respons til opretter"
        }
        elseif ($r.LastResponseDays -ge $CommunicationInactiveDays) {
            Add-Attention $r "⚠️" "Kommunikation bør vurderes: seneste respons til opretter er $($r.LastResponseDays) dage gammel"
        }
    }

    if ($r.State -eq "closed") {
        Add-Attention $r "🔴" "GitHub-issue er lukket, men står fortsat i aktiv Project-status"
    }
}


# ---------------------------
# Fælles PO-nøgletal
# ---------------------------

$near6RowsGlobal = @(
    $active |
    Where-Object { $_.AgeDays -ge 137 -and $_.AgeDays -le 183 } |
    Sort-Object AgeDays -Descending
)

$over6RowsGlobal = @(
    $active |
    Where-Object { $_.AgeDays -gt 183 } |
    Sort-Object AgeDays -Descending
)

$communicationQueueGlobal = @(
    $active |
    Where-Object {
        $_.AgeDays -ge $CommunicationAgeDays -and
        (
            $null -eq $_.LastResponseAt -or
            $_.LastResponseDays -ge $CommunicationInactiveDays
        )
    } |
    Sort-Object AgeDays -Descending
)

$overdueReleaseRows = @(
    $active |
    Where-Object {
        $null -ne $_.ReleaseEnd -and
        $_.ReleaseEnd.Date -lt $generatedAt.Date
    }
)

$criticalHighInactiveRows = @(
    $active |
    Where-Object {
        $_.Priority -in @("Kritisk","Høj") -and
        $_.InactiveDays -ge $HighPriorityInactiveDays
    }
)

$closedActiveRows = @(
    $active | Where-Object { $_.State -eq "closed" }
)

$readyRowsGlobal = @(
    $active | Where-Object { $_.Status -eq "Klar til prioritering" }
)

$readyMissingPriorityRows = @(
    $readyRowsGlobal | Where-Object { [string]::IsNullOrWhiteSpace($_.Priority) }
)

$readyMissingEstimateRows = @(
    $readyRowsGlobal | Where-Object { [string]::IsNullOrWhiteSpace($_.Estimate) }
)

$readyReviewedRows = @(
    $readyRowsGlobal | Where-Object { $_.HasPoReview }
)

$readyMissingReviewRows = @(
    $readyRowsGlobal | Where-Object { -not $_.HasPoReview }
)

$readyReviewRedRows = @(
    $readyRowsGlobal | Where-Object { $_.HasPoReview -and $_.PoReviewSignal -eq "🔴" }
)

$readyReviewYellowRows = @(
    $readyRowsGlobal | Where-Object { $_.HasPoReview -and $_.PoReviewSignal -eq "🟡" }
)

$readyReviewNewCommentsRows = @(
    $readyRowsGlobal | Where-Object { $_.HasPoReview -and $_.NewCommentsSincePoReview -gt 0 }
)

$orderedMissingReleaseRows = @(
    $active |
    Where-Object {
        $_.Status -in @("Bestilt hos leverandør","Igangværende opgaver") -and
        [string]::IsNullOrWhiteSpace($_.Release)
    }
)

$orderedMissingAssigneeRows = @(
    $active |
    Where-Object {
        $_.Status -in @("Bestilt hos leverandør","Igangværende opgaver") -and
        [string]::IsNullOrWhiteSpace($_.Assignees)
    }
)

$testReviewStaleRows = @(
    $active |
    Where-Object {
        $_.Status -in @("Løsninger i test","Løsninger i review") -and
        $_.InactiveDays -ge $TestReviewInactiveDays
    }
)

$releaseCandidateRows = @(
    $active |
    Where-Object {
        $_.Status -in @("Klar til prioritering","Bestilt hos leverandør","Igangværende opgaver") -and
        [string]::IsNullOrWhiteSpace($_.Release)
    } |
    Sort-Object PriorityRank, @{Expression={$_.AgeDays};Descending=$true}
)


# ---------------------------
# Flow / flaskehalse
# ---------------------------

$activeStatusRows = @()

foreach ($status in $statusOrder) {
    if ($status -in @("Afsluttede løsninger","Won't fix")) { continue }

    $stageRows = @($active | Where-Object { $_.Status -eq $status })
    if ($stageRows.Count -eq 0) { continue }

    $ages = @($stageRows | ForEach-Object { [double]$_.AgeDays })
    $medianStageAge = [math]::Round((Median $ages),0)
    $oldestStageAge = ($stageRows | Measure-Object AgeDays -Maximum).Maximum

    $statusAges = @($stageRows | ForEach-Object { [double]$_.StatusAgeDays })
    $medianStatusAge = [math]::Round((Median $statusAges),0)
    $oldestStatusAge = ($stageRows | Measure-Object StatusAgeDays -Maximum).Maximum

    $near6Stage = @($stageRows | Where-Object { $_.AgeDays -ge 137 -and $_.AgeDays -le 183 }).Count
    $over6Stage = @($stageRows | Where-Object { $_.AgeDays -gt 183 }).Count

    $share = 0
    if ($active.Count -gt 0) {
        $share = [math]::Round(($stageRows.Count / $active.Count) * 100, 1)
    }

    $activeStatusRows += [PSCustomObject]@{
        Status = $status
        Count = $stageRows.Count
        Share = $share
        MedianAge = [int]$medianStageAge
        OldestAge = [int]$oldestStageAge
        MedianStatusAge = [int]$medianStatusAge
        OldestStatusAge = [int]$oldestStatusAge
        Near6 = $near6Stage
        Over6 = $over6Stage
    }
}

$bottleneck = $null
if ($activeStatusRows.Count -gt 0) {
    $bottleneck = $activeStatusRows | Sort-Object Count -Descending | Select-Object -First 1
}

# ---------------------------
# Markdown
# ---------------------------

$md = New-Object System.Collections.Generic.List[string]

# ---------------------------
# PO-cockpit – første skærm
# ---------------------------

$md.Add("# PO-overblik – OS2sofd")
$md.Add("")
$md.Add("Senest genereret: **$($generatedAt.ToString("dd-MM-yyyy HH:mm"))**  ")
$md.Add("Aktuel release: **$(Escape-Md $currentReleaseName)**")
$md.Add("")
$md.Add("> **Formål:** Første skærm viser kun det, der kræver PO-handling eller bør påvirke en beslutning nu. Alle detaljer og analysedata findes foldet sammen længere nede.")
$md.Add("")

$md.Add("## PO-fokus lige nu")
$md.Add("")
$md.Add("| Signal | Hvad skal PO gøre? | Issues |")
$md.Add("| --- | --- | --- |")

$focusRowsAdded = 0

if ($readyReviewRedRows.Count -gt 0) {
    $md.Add("| 🔴 | Afklar røde PO-reviews før prioritering | $(Issue-Refs $readyReviewRedRows) |")
    $focusRowsAdded++
}
if ($criticalHighInactiveRows.Count -gt 0) {
    $md.Add("| 🔴 | Følg op på Kritisk/Høj uden opdatering i mindst $HighPriorityInactiveDays dage | $(Issue-Refs $criticalHighInactiveRows) |")
    $focusRowsAdded++
}
if ($overdueReleaseRows.Count -gt 0) {
    $md.Add("| 🔴 | Afklar udløbet planlagt release | $(Issue-Refs $overdueReleaseRows) |")
    $focusRowsAdded++
}
if ($closedActiveRows.Count -gt 0) {
    $md.Add("| 🔴 | Ryd op i lukkede GitHub-issues, der stadig står aktivt i Project | $(Issue-Refs $closedActiveRows) |")
    $focusRowsAdded++
}
if ($readyMissingPriorityRows.Count -gt 0) {
    $md.Add("| 🟠 | Fastlæg manglende prioritet | $(Issue-Refs $readyMissingPriorityRows) |")
    $focusRowsAdded++
}
if ($readyMissingEstimateRows.Count -gt 0) {
    $md.Add("| 🟠 | Få manglende estimat på plads | $(Issue-Refs $readyMissingEstimateRows) |")
    $focusRowsAdded++
}
if ($readyMissingReviewRows.Count -gt 0) {
    $md.Add("| 🟠 | Gennemfør manglende PO-review | $(Issue-Refs $readyMissingReviewRows) |")
    $focusRowsAdded++
}
if ($orderedMissingReleaseRows.Count -gt 0) {
    $md.Add("| 🟠 | Fastlæg planlagt release | $(Issue-Refs $orderedMissingReleaseRows) |")
    $focusRowsAdded++
}
if ($orderedMissingAssigneeRows.Count -gt 0) {
    $md.Add("| 🟠 | Vurder/fastlæg assignee | $(Issue-Refs $orderedMissingAssigneeRows) |")
    $focusRowsAdded++
}
if ($testReviewStaleRows.Count -gt 0) {
    $md.Add("| 🟡 | Følg op på test/review uden opdatering i mindst $TestReviewInactiveDays dage | $(Issue-Refs $testReviewStaleRows) |")
    $focusRowsAdded++
}
if ($focusRowsAdded -eq 0) {
    $md.Add("| 🟢 | Ingen konkrete PO-handlinger identificeret | – |")
}

$md.Add("")

$deliveryOrdered = @($active | Where-Object { $_.Status -eq "Bestilt hos leverandør" })
$deliveryInProgress = @($active | Where-Object { $_.Status -eq "Igangværende opgaver" })
$deliveryTest = @($active | Where-Object { $_.Status -eq "Løsninger i test" })
$deliveryReview = @($active | Where-Object { $_.Status -eq "Løsninger i review" })

$md.Add("### Aktuel levering")
$md.Add("")
$md.Add("| Status | Antal |")
$md.Add("| --- | ---: |")
$md.Add("| Bestilt hos leverandør | $($deliveryOrdered.Count) |")
$md.Add("| Igangværende | $($deliveryInProgress.Count) |")
$md.Add("| I test | $($deliveryTest.Count) |")
$md.Add("| I review | $($deliveryReview.Count) |")
$md.Add("")

$md.Add("### Flow")
$md.Add("")
if ($null -ne $bottleneck) {
    $md.Add("- 🔴 **Største aktuelle kø:** $($bottleneck.Count) issues i **$(Escape-Md $bottleneck.Status)** ($($bottleneck.Share) % af de aktive).")
}
$md.Add("- 🟡 **$($readyRowsGlobal.Count) issues** er klar til prioritering.")
$md.Add("- ℹ️ **$($active.Count) aktive ændringsønsker** i alt.")
$md.Add("")

$md.Add("### Backlog-sundhed")
$md.Add("")
$md.Add("- **$($over6RowsGlobal.Count)** aktive issues er over 6 måneder gamle.")
$md.Add("- **$($near6RowsGlobal.Count)** ligger mellem 4,5 og 6 måneder.")
$md.Add("- Alder er et strategisk signal og løftes ikke alene til PO-fokus.")
$md.Add("")

$md.Add("---")
$md.Add("")
$md.Add("## Detaljer og analyse")
$md.Add("")
$md.Add("Alt nedenfor er fortsat tilgængeligt, men er foldet sammen som standard.")
$md.Add("")
$md.Add("<details>")
$md.Add("<summary><strong>Om data og målegrundlag</strong></summary>")
$md.Add("")
$md.Add("- Alder beregnes fra GitHub-issuets oprettelsesdato. For migrerede JIRA-sager kan reel alder være højere.")
$md.Add("- Statushistorikken registreres fra automatiseringens første observation. `≥` betyder, at reel tid i status kan være længere.")
$md.Add("- GitHub Project er den autoritative datakilde.")
$md.Add("")
$md.Add("</details>")
$md.Add("")

# 1. PO-opmærksomhed
$md.Add("<details>")
$md.Add("<summary><strong>PO-signaler og handlingsdetaljer</strong></summary>")
$md.Add("")
$md.Add("## PO-signaler og handlingsdetaljer")
$md.Add("")

$attentionRows = @(
    $attention.Values |
    Sort-Object `
        @{Expression={
            if ($_.Signals -contains "🔴") { 1 }
            elseif ($_.Signals -contains "🟠") { 2 }
            elseif ($_.Signals -contains "🟡") { 3 }
            elseif ($_.Signals -contains "⚠️") { 4 }
            else { 5 }
        }; Ascending=$true},
        @{Expression={ $_.Row.PriorityRank }; Ascending=$true},
        @{Expression={ $_.Row.AgeDays }; Descending=$true}
)

$md.Add("### Samlet PO-signal")
$md.Add("")
$md.Add("| Signal | Område | Antal |")
$md.Add("| --- | --- | ---: |")
$md.Add("| 🔴 | Udløbet planlagt release | $($overdueReleaseRows.Count) |")
$md.Add("| 🔴 | Kritisk/Høj uden opdatering i mindst $HighPriorityInactiveDays dage | $($criticalHighInactiveRows.Count) |")
$md.Add("| 🔴 | Lukket GitHub-issue i aktiv Project-status | $($closedActiveRows.Count) |")
$md.Add("| 🔴 | Klar til prioritering uden prioritet | $($readyMissingPriorityRows.Count) |")
$md.Add("| 🔴 | Klar til prioritering uden estimat | $($readyMissingEstimateRows.Count) |")
$md.Add("| 🟡 | Klar til prioritering uden PO-review | $($readyMissingReviewRows.Count) |")
$md.Add("| 🔴 | PO-review kræver afklaring | $($readyReviewRedRows.Count) |")
$md.Add("| ⚠️ | Reviewede issues med nye kommentarer | $($readyReviewNewCommentsRows.Count) |")
$md.Add("| 🟡 | Bestilt/igangværende uden planlagt release | $($orderedMissingReleaseRows.Count) |")
$md.Add("| ℹ️ | Bestilt/igangværende uden assignee | $($orderedMissingAssigneeRows.Count) |")
$md.Add("| 🟡 | Test/review uden opdatering i mindst $TestReviewInactiveDays dage | $($testReviewStaleRows.Count) |")
$md.Add("| ⚠️ | Kommunikation bør vurderes | $($communicationQueueGlobal.Count) |")
$md.Add("")

$md.Add("### Foreslåede næste PO-handlinger")
$md.Add("")

$nextActions = @()

if ($closedActiveRows.Count -gt 0) {
    $nextActions += "Ryd op i **$($closedActiveRows.Count)** lukket/lukkede GitHub-issue(s), der stadig står i en aktiv Project-status."
}
if ($criticalHighInactiveRows.Count -gt 0) {
    $nextActions += "Følg op på **$($criticalHighInactiveRows.Count)** Kritisk/Høj-prioriteret issue(s) uden opdatering i mindst $HighPriorityInactiveDays dage."
}
if ($readyMissingPriorityRows.Count -gt 0) {
    $nextActions += "Fastlæg prioritet på **$($readyMissingPriorityRows.Count)** issue(s) i **Klar til prioritering**."
}
if ($readyMissingEstimateRows.Count -gt 0) {
    $nextActions += "Få estimat på **$($readyMissingEstimateRows.Count)** issue(s) i **Klar til prioritering**."
}
if ($readyMissingReviewRows.Count -gt 0) {
    $nextActions += "Gennemfør PO-review af løsningsbeskrivelsen på **$($readyMissingReviewRows.Count)** issue(s) i **Klar til prioritering**."
}
if ($readyReviewRedRows.Count -gt 0) {
    $nextActions += "Afklar **$($readyReviewRedRows.Count)** issue(s), hvor PO-reviewet er rødt, før koordinationsgruppens prioritering."
}
if ($readyReviewNewCommentsRows.Count -gt 0) {
    $nextActions += "Vurder nye kommentarer på **$($readyReviewNewCommentsRows.Count)** allerede reviewet/reviewede issue(s) og afgør, om der er behov for opfølgende review."
}
if ($orderedMissingReleaseRows.Count -gt 0) {
    $nextActions += "Fastlæg planlagt release på **$($orderedMissingReleaseRows.Count)** bestilt/igangværende issue(s)."
}
if ($orderedMissingAssigneeRows.Count -gt 0) {
    $nextActions += "Vurder om der bør sættes assignee på **$($orderedMissingAssigneeRows.Count)** bestilt/igangværende issue(s)."
}
if ($overdueReleaseRows.Count -gt 0) {
    $nextActions += "Afklar **$($overdueReleaseRows.Count)** issue(s) med udløbet planlagt release – enten færdiggør, omplanlæg eller afslut."
}
if ($communicationQueueGlobal.Count -gt 0) {
    $nextActions += "Vurder individuel statuskommunikation på **$($communicationQueueGlobal.Count)** ældre issue(s)."
}
# Backlog-alder vises som strategisk signal i cockpit og omløbstidsdelen.
# Den skaber ikke automatisk en konkret PO-handling.

if ($nextActions.Count -eq 0) {
    $md.Add("Ingen særlige PO-handlinger identificeret.")
}
else {
    foreach ($action in $nextActions) {
        $md.Add("- $action")
    }
}

$md.Add("")

if ($attentionRows.Count -eq 0) {
    $md.Add("Ingen aktuelle PO-signaler.")
}
else {
    $md.Add("<details>")
    $md.Add("<summary>Vis konkrete issues, der kræver PO-opmærksomhed ($($attentionRows.Count))</summary>")
    $md.Add("")
    $md.Add("| Signal | Issue | Status | Prioritet | Alder | PO-opmærksomhed |")
    $md.Add("| --- | --- | --- | --- | ---: | --- |")

    foreach ($a in $attentionRows) {
        $r = $a.Row
        $signalOrder = @("🔴","🟠","🟡","⚠️","🔵")
        $signal = (($signalOrder | Where-Object { $a.Signals -contains $_ }) -join " ")
        $reason = ($a.Reasons | Select-Object -Unique) -join "; "
        $md.Add("| $signal | $(Issue-Link $r.Number $r.Title $r.Url) | $(Escape-Md $r.Status) | $(Escape-Md $r.Priority) | $(Age-Text $r.AgeDays) | $(Escape-Md $reason) |")
    }

    $md.Add("")
    $md.Add("</details>")
}

$md.Add("")
$md.Add("> **Bemærk:** Kommunikationssignalet er en indikator. Det ser på seneste kommentar fra en anden end den oprindelige opretter. Det kan stadig ikke i sig selv afgøre, om opretter faktisk er tilstrækkeligt orienteret.")
$md.Add("")
$md.Add("</details>")
$md.Add("")

# 2. Omløbstid og kommunikation
$md.Add("<details>")
$md.Add("<summary><strong>Omløbstid og kommunikation</strong></summary>")
$md.Add("")
$md.Add("## 2. Omløbstid og kommunikation")
$md.Add("")

$activeAges = @($active | ForEach-Object { [double]$_.AgeDays })
$avgAge = 0
$medianAge = 0

if ($activeAges.Count -gt 0) {
    $avgAge = [math]::Round((($activeAges | Measure-Object -Average).Average),0)
    $medianAge = [math]::Round((Median $activeAges),0)
}

$over6 = @($active | Where-Object { $_.AgeDays -gt 183 }).Count
$over12 = @($active | Where-Object { $_.AgeDays -gt 365 }).Count
$near6Rows = $near6RowsGlobal
$near6 = $near6Rows.Count

$communicationQueue = $communicationQueueGlobal
$commReview = $communicationQueue.Count

$md.Add("| Nøgletal | Antal / værdi |")
$md.Add("| --- | ---: |")
$md.Add("| Aktive ændringsønsker | $($active.Count) |")
$md.Add("| Gennemsnitlig alder | $(Age-Text ([int]$avgAge)) |")
$md.Add("| Median alder | $(Age-Text ([int]$medianAge)) |")
$md.Add("| 4,5–6 måneder gamle | $near6 |")
$md.Add("| Over 6 måneder | $over6 |")
$md.Add("| Over 12 måneder | $over12 |")
$md.Add("| Kommunikation bør vurderes | $commReview |")
$md.Add("| Aktive issues med JIRA-reference | $($activeWithJiraReference.Count) |")
$md.Add("")

if ($activeWithJiraReference.Count -gt 0) {
    $md.Add("> ℹ️ **Målegrundlag:** $($activeWithJiraReference.Count) aktive issues har en JIRA-reference. For disse kan GitHub-alderen være lavere end den reelle alder på ændringsønsket.")
    $md.Add("")
}

if ($over6 -gt 0) {
    $md.Add("> 📣 **Generel kommunikation anbefales:** $over6 aktive ændringsønsker har en GitHub-alder over 6 måneder. For ønsker med historik før GitHub kan den reelle omløbstid være endnu længere.")
    $md.Add("")
}
elseif ($near6 -ge 10) {
    $md.Add("> 📣 **Generel kommunikation anbefales:** $near6 aktive ændringsønsker ligger allerede mellem 4,5 og 6 måneder. Der bør kommunikeres om den aktuelle backlog, de tilførte ressourcer og målet om højst 6 måneders omløbstid.")
    $md.Add("")
}

if ($commReview -gt 0) {
    $md.Add("> 👤 **Individuel kommunikation:** $commReview ældre issues bør vurderes konkret i forhold til, om opretter har fået en tilstrækkelig og aktuel status.")
    $md.Add("")
}

$md.Add("### Kommunikationskø")
$md.Add("")

if ($communicationQueue.Count -eq 0) {
    $md.Add("Ingen ældre aktive issues rammer den aktuelle kommunikationsregel.")
}
else {
    $md.Add("| Issue | Alder | Status | Prioritet | Seneste respons til opretter |")
    $md.Add("| --- | ---: | --- | --- | ---: |")

    foreach ($r in $communicationQueue) {
        $responseText = if ($null -eq $r.LastResponseAt) {
            "Ingen registreret respons"
        } else {
            "$($r.LastResponseDays) dage siden"
        }

        $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Status) | $(Escape-Md $r.Priority) | $(Escape-Md $responseText) |")
    }
}

$md.Add("")

$md.Add("### Nærmer sig 6-månedersgrænsen")
$md.Add("")

if ($near6Rows.Count -eq 0) {
    $md.Add("Ingen aktive issues ligger aktuelt mellem 4,5 og 6 måneder.")
}
else {
    $md.Add("<details>")
    $md.Add("<summary>Vis alle $near6 issues mellem 4,5 og 6 måneder</summary>")
    $md.Add("")
    $md.Add("| Issue | Alder | Status | Prioritet | Kommune |")
    $md.Add("| --- | ---: | --- | --- | --- |")

    foreach ($r in $near6Rows) {
        $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Status) | $(Escape-Md $r.Priority) | $(Escape-Md $r.Municipality) |")
    }

    $md.Add("")
    $md.Add("</details>")
}

$md.Add("")

$md.Add("### Ældste aktive ændringsønsker")
$md.Add("")
$md.Add("| Signal | Issue | Alder | Status | Prioritet | Senest opdateret |")
$md.Add("| --- | --- | ---: | --- | --- | ---: |")

foreach ($r in @($active | Sort-Object AgeDays -Descending | Select-Object -First 10)) {
    $md.Add("| $(Age-Signal $r.AgeDays) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Status) | $(Escape-Md $r.Priority) | $($r.InactiveDays) dage siden |")
}

$md.Add("")

$md.Add("</details>")
$md.Add("")

# 3. Flow og flaskehalse
$md.Add("<details>")
$md.Add("<summary><strong>Flow og flaskehalse</strong></summary>")
$md.Add("")
$md.Add("## 3. Flow og flaskehalse")
$md.Add("")

if ($null -ne $bottleneck) {
    if ($bottleneck.Share -ge 50) {
        $md.Add("> ⚠️ **Aktuel største kø / potentiel flaskehals:** $($bottleneck.Count) af $($active.Count) aktive ændringsønsker ($($bottleneck.Share) %) står i **$($bottleneck.Status)**. Rapporten kan endnu ikke måle tid i status historisk, så den kan ikke alene afgøre, om dette er en vedvarende flaskehals.")
    }
    else {
        $md.Add("> Største aktuelle kø er **$($bottleneck.Status)** med $($bottleneck.Count) issues ($($bottleneck.Share) % af de aktive).")
    }
    $md.Add("")
}

$md.Add("| Status | Antal | Andel af aktive | Median GitHub-alder | Median observeret tid i status | Ældste observerede tid i status | 4,5–6 mdr. GitHub-alder | >6 mdr. GitHub-alder |")
$md.Add("| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |")

foreach ($s in $activeStatusRows) {
    $md.Add("| $(Escape-Md $s.Status) | $($s.Count) | $($s.Share) % | $(Age-Text $s.MedianAge) | $(Age-Text $s.MedianStatusAge) | $(Age-Text $s.OldestStatusAge) | $($s.Near6) | $($s.Over6) |")
}

$md.Add("")
$md.Add("_Observeret tid i status tælles fra første registrering i historikfilen. For baseline-issues kan den reelle tid i status være længere._")

$md.Add("")

$md.Add("</details>")
$md.Add("")

# 4. Klar til prioritering
$md.Add("<details>")
$md.Add("<summary><strong>Klar til prioritering</strong></summary>")
$md.Add("")
$md.Add("## 4. Klar til prioritering")
$md.Add("")

$ready = @(
    $rows |
    Where-Object { $_.Status -eq "Klar til prioritering" } |
    Sort-Object PriorityRank, @{Expression={$_.AgeDays};Descending=$true}
)

if ($ready.Count -eq 0) {
    $md.Add("Ingen issues er aktuelt klar til prioritering.")
}
else {
    $md.Add("| Prioritet | Issue | Alder | Tid i status | Labels | Kommune | Estimat | Størrelse | Release |")
    $md.Add("| --- | --- | ---: | ---: | --- | --- | ---: | --- | --- |")

    foreach ($r in $ready) {
        $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Format-StatusAge $r.StatusAgeDays $r.StatusAgeIsBaseline) | $(Escape-Md $r.Labels) | $(Escape-Md $r.Municipality) | $(Escape-Md $r.Estimate) | $(Escape-Md $r.Size) | $(Escape-Md $r.Release) |")
    }
}

$md.Add("")

$md.Add("</details>")
$md.Add("")

# 5. Review af løsningsbeskrivelser
$md.Add("<details>")
$md.Add("<summary><strong>Review af løsningsbeskrivelser</strong></summary>")
$md.Add("")
$md.Add("## 5. Review af løsningsbeskrivelser")
$md.Add("")
$md.Add("> PO-reviewet er et kvalitetslag oven på det eksisterende flow. Reviewet baseres på issue, løsningsbeskrivelse og eksisterende kommentarer på reviewtidspunktet.")
$md.Add("")
$md.Add("| Nøgletal | Antal |")
$md.Add("| --- | ---: |")
$md.Add("| Klar til prioritering | $($readyRowsGlobal.Count) |")
$md.Add("| Reviewet | $($readyReviewedRows.Count) |")
$md.Add("| Mangler PO-review | $($readyMissingReviewRows.Count) |")
$md.Add("| Review med opmærksomhedspunkter | $($readyReviewYellowRows.Count) |")
$md.Add("| Review kræver afklaring | $($readyReviewRedRows.Count) |")
$md.Add("| Reviewet med nye kommentarer siden seneste review | $($readyReviewNewCommentsRows.Count) |")
$md.Add("")

if ($readyRowsGlobal.Count -eq 0) {
    $md.Add("Ingen issues er aktuelt i **Klar til prioritering**.")
}
else {
    $md.Add("| Issue | Estimat | PO-review | Opmærksomhed | Nye kommentarer siden review |")
    $md.Add("| --- | ---: | --- | --- | ---: |")

    foreach ($r in @($readyRowsGlobal | Sort-Object PriorityRank, @{Expression={$_.AgeDays};Descending=$true})) {
        if (-not $r.HasPoReview) {
            $reviewText = "Ikke reviewet"
            $attentionText = "–"
            $newCommentsText = "–"
        }
        else {
            $reviewText = if ([string]::IsNullOrWhiteSpace($r.PoReviewSignal)) {
                "Review $($r.PoReviewNumber)"
            }
            else {
                "$($r.PoReviewSignal) Review $($r.PoReviewNumber)"
            }

            $attentionText = if ([string]::IsNullOrWhiteSpace($r.PoReviewAttention)) {
                "–"
            }
            else {
                $r.PoReviewAttention
            }

            $newCommentsText = [string]$r.NewCommentsSincePoReview
        }

        $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Escape-Md $r.Estimate) | $(Escape-Md $reviewText) | $(Escape-Md $attentionText) | $(Escape-Md $newCommentsText) |")
    }
}

$md.Add("")
$md.Add("> **Nye kommentarer siden review:** Kendte automatiske proceskommentarer tælles ikke med. Et nyt kommentarspor er kun et signal om, at PO bør vurdere relevansen; det udløser ikke automatisk et nyt review.")
$md.Add("")

$md.Add("</details>")
$md.Add("")

# 6. Release-overblik
$md.Add("<details>")
$md.Add("<summary><strong>Release-overblik – $currentReleaseName</strong></summary>")
$md.Add("")
$md.Add("## 6. Release-overblik – $currentReleaseName")
$md.Add("")

$currentReleaseRows = @(
    $rows |
    Where-Object { $_.Release -eq $currentReleaseName } |
    Sort-Object PriorityRank, @{Expression={$_.AgeDays};Descending=$true}
)

if ($currentReleaseRows.Count -eq 0) {
    $md.Add("> 🔴 **Ingen issues er registreret med planlagt release $currentReleaseName.** Hvis der fortsat arbejdes mod en release i dette kvartal, bør planlagt release opdateres på de valgte issues.")
}
else {
    $md.Add("| Status | Antal |")
    $md.Add("| --- | ---: |")

    foreach ($status in $statusOrder) {
        $count = @($currentReleaseRows | Where-Object { $_.Status -eq $status }).Count
        if ($count -gt 0) {
            $md.Add("| $(Escape-Md $status) | $count |")
        }
    }

    $md.Add("")
    $md.Add("| Prioritet | Issue | Alder | Status | Estimat | Assignee |")
    $md.Add("| --- | --- | ---: | --- | ---: | --- |")

    foreach ($r in $currentReleaseRows) {
        $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Status) | $(Escape-Md $r.Estimate) | $(Escape-Md $r.Assignees) |")
    }
}

$md.Add("")
$md.Add("### Release-efterslæb")
$md.Add("")

if ($overdueReleaseRows.Count -eq 0) {
    $md.Add("Ingen aktive issues har en udløbet planlagt release.")
}
else {
    $releaseDebtGroups = @(
        $overdueReleaseRows |
        Group-Object Release |
        Sort-Object Count -Descending
    )

    $md.Add("| Udløbet release | Antal aktive issues |")
    $md.Add("| --- | ---: |")

    foreach ($g in $releaseDebtGroups) {
        $md.Add("| $(Escape-Md $g.Name) | $($g.Count) |")
    }

    $md.Add("")
    $md.Add("<details>")
    $md.Add("<summary>Vis konkrete issues med udløbet release ($($overdueReleaseRows.Count))</summary>")
    $md.Add("")
    $md.Add("| Issue | Alder | Status | Release | Senest opdateret |")
    $md.Add("| --- | ---: | --- | --- | ---: |")

    foreach ($r in @($overdueReleaseRows | Sort-Object Release, @{Expression={$_.AgeDays};Descending=$true})) {
        $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Status) | $(Escape-Md $r.Release) | $($r.InactiveDays) dage siden |")
    }

    $md.Add("")
    $md.Add("</details>")
}

$md.Add("")

$md.Add("### Kandidater uden planlagt release")
$md.Add("")

if ($releaseCandidateRows.Count -eq 0) {
    $md.Add("Ingen issues i Klar til prioritering / Bestilt / Igangværende mangler planlagt release.")
}
else {
    $md.Add("| Prioritet | Issue | Alder | Status | Estimat | Assignee |")
    $md.Add("| --- | --- | ---: | --- | ---: | --- |")

    foreach ($r in $releaseCandidateRows) {
        $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Status) | $(Escape-Md $r.Estimate) | $(Escape-Md $r.Assignees) |")
    }
}

$md.Add("")

$md.Add("</details>")
$md.Add("")

# 7. Hele pipeline
$md.Add("<details>")
$md.Add("<summary><strong>Hele pipeline – Fra idé til færdig løsning</strong></summary>")
$md.Add("")
$md.Add("## 7. Hele pipeline – Fra idé til færdig løsning")
$md.Add("")
$md.Add("| Status | Antal |")
$md.Add("| --- | ---: |")

foreach ($status in $statusOrder) {
    $count = @($rows | Where-Object { $_.Status -eq $status }).Count
    $md.Add("| $(Escape-Md $status) | $count |")
}

$unknownStatuses = @(
    $rows |
    Where-Object { $_.Status -notin $statusOrder } |
    Group-Object Status
)

foreach ($g in $unknownStatuses) {
    $md.Add("| $(Escape-Md $g.Name) | $($g.Count) |")
}

$md.Add("")

foreach ($status in $statusOrder) {
    $statusRows = @(
        $rows |
        Where-Object { $_.Status -eq $status } |
        Sort-Object PriorityRank, @{Expression={$_.AgeDays};Descending=$true}
    )

    if ($statusRows.Count -eq 0) { continue }

    if ($status -eq "Afsluttede løsninger") {
        $md.Add("### $status")
        $md.Add("")
        $md.Add("> Gennemløbstid vises kun, når der findes en registreret afslutningsdato. Fremadrettet kan automatiseringen opbygge status-historik og dermed måle gennemløbstid mere præcist.")
    }
    elseif ($status -eq "Won't fix") {
        $md.Add("### Won't fix")
    }
    else {
        $md.Add("### $status")
    }

    $md.Add("")

    $collapseStatus = ($status -notin @("Klar til prioritering"))

    if ($collapseStatus) {
        $md.Add("<details>")
        $md.Add("<summary>Vis $($statusRows.Count) issue(s)</summary>")
        $md.Add("")
    }

    if ($statusRows.Count -eq 0) {
        $md.Add("Ingen issues i denne status.")
        $md.Add("")
        continue
    }

    switch ($status) {
        { $_ -in @("Nye ændringsønsker","Screening") } {
            $md.Add("| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |")
            $md.Add("| --- | --- | ---: | --- | --- | ---: |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Municipality) | $(Escape-Md $r.Labels) | $($r.InactiveDays) dage siden |")
            }
            break
        }

        "Afventer løsningsbeskrivelse" {
            $md.Add("| Prioritet | Issue | Alder | Labels | Kommune | Assignee | Senest opdateret |")
            $md.Add("| --- | --- | ---: | --- | --- | --- | ---: |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Labels) | $(Escape-Md $r.Municipality) | $(Escape-Md $r.Assignees) | $($r.InactiveDays) dage siden |")
            }
            break
        }

        "Klar til prioritering" {
            $md.Add("| Prioritet | Issue | Alder | Estimat | Størrelse | Release | Kommune |")
            $md.Add("| --- | --- | ---: | ---: | --- | --- | --- |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Estimate) | $(Escape-Md $r.Size) | $(Escape-Md $r.Release) | $(Escape-Md $r.Municipality) |")
            }
            break
        }

        { $_ -in @("Bestilt hos leverandør","Igangværende opgaver") } {
            $md.Add("| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |")
            $md.Add("| --- | --- | ---: | --- | ---: | --- | ---: |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Assignees) | $(Escape-Md $r.Estimate) | $(Escape-Md $r.Release) | $($r.InactiveDays) dage siden |")
            }
            break
        }

        { $_ -in @("Løsninger i test","Løsninger i review") } {
            $md.Add("| Issue | Alder | Release | Assignee | Senest opdateret |")
            $md.Add("| --- | ---: | --- | --- | ---: |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Release) | $(Escape-Md $r.Assignees) | $($r.InactiveDays) dage siden |")
            }
            break
        }

        "Afsluttede løsninger" {
            $md.Add("| Issue | Gennemløbstid | Prioritet | Release | Afsluttet |")
            $md.Add("| --- | ---: | --- | --- | --- |")
            foreach ($r in $statusRows) {
                $completionDate = $null

                if ($null -ne $r.ProjectEndDate) {
                    $completionDate = $r.ProjectEndDate
                }
                elseif ($null -ne $r.ClosedAt) {
                    $completionDate = $r.ClosedAt
                }

                if ($null -ne $completionDate) {
                    $cycleDays = [math]::Floor(($completionDate - $r.CreatedAt).TotalDays)
                    $cycleText = Age-Text $cycleDays
                    $completionText = $completionDate.ToString("dd-MM-yyyy")
                }
                else {
                    $cycleText = "–"
                    $completionText = "–"
                }

                $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Escape-Md $cycleText) | $(Escape-Md $r.Priority) | $(Escape-Md $r.Release) | $completionText |")
            }
            break
        }

        "Won't fix" {
            $md.Add("| Issue | Alder | Kommune | Senest opdateret |")
            $md.Add("| --- | ---: | --- | --- |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Municipality) | $($r.UpdatedAt.ToString("dd-MM-yyyy")) |")
            }
            break
        }

        default {
            $md.Add("| Prioritet | Issue | Alder | Kommune | Release | Senest opdateret |")
            $md.Add("| --- | --- | ---: | --- | --- | ---: |")
            foreach ($r in $statusRows) {
                $md.Add("| $(Escape-Md $r.Priority) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Age-Text $r.AgeDays) | $(Escape-Md $r.Municipality) | $(Escape-Md $r.Release) | $($r.InactiveDays) dage siden |")
            }
        }
    }

    if ($collapseStatus) {
        $md.Add("")
        $md.Add("</details>")
    }

    $md.Add("")
}

$md.Add("</details>")
$md.Add("")

# 8. Datakvalitet
$md.Add("<details>")
$md.Add("<summary><strong>Proces- og datakvalitet</strong></summary>")
$md.Add("")
$md.Add("## Proces- og datakvalitet")
$md.Add("")

$dataQuality = @()

foreach ($r in $active) {
    $problems = @()

    if (
        [string]::IsNullOrWhiteSpace($r.Priority) -and
        $r.Status -in @("Afventer løsningsbeskrivelse","Klar til prioritering","Bestilt hos leverandør","Igangværende opgaver")
    ) {
        $problems += "Mangler prioritet"
    }

    if ([string]::IsNullOrWhiteSpace($r.Labels)) {
        $problems += "Mangler faglig label"
    }

    if ($r.Status -eq "Klar til prioritering" -and [string]::IsNullOrWhiteSpace($r.Estimate)) {
        $problems += "Mangler estimat"
    }

    if ($r.Status -eq "Klar til prioritering" -and -not $r.HasPoReview) {
        $problems += "Mangler PO-review af løsningsbeskrivelsen"
    }

    if ($r.Status -eq "Klar til prioritering" -and $r.HasPoReview -and $r.NewCommentsSincePoReview -gt 0) {
        $problems += "Nye kommentarer siden seneste PO-review bør vurderes"
    }

    if ($r.Status -in @("Bestilt hos leverandør","Igangværende opgaver","Løsninger i test","Løsninger i review") -and [string]::IsNullOrWhiteSpace($r.Release)) {
        $problems += "Mangler planlagt release"
    }

    if ($null -ne $r.ReleaseEnd -and $r.ReleaseEnd.Date -lt $generatedAt.Date) {
        $problems += "Planlagt release er udløbet"
    }

    if ($r.State -eq "closed") {
        $problems += "Issue er lukket, men Project-status er aktiv"
    }

    if ($problems.Count -gt 0) {
        $dataQuality += [PSCustomObject]@{
            Row = $r
            Problems = $problems -join "; "
        }
    }
}

if ($dataQuality.Count -eq 0) {
    $md.Add("Ingen åbenlyse proces- eller datakvalitetsproblemer fundet.")
}
else {
    $md.Add("| Issue | Status | Alder | Problem |")
    $md.Add("| --- | --- | ---: | --- |")

    foreach ($d in @($dataQuality | Sort-Object @{Expression={$_.Row.AgeDays};Descending=$true})) {
        $r = $d.Row
        $md.Add("| $(Issue-Link $r.Number $r.Title $r.Url) | $(Escape-Md $r.Status) | $(Age-Text $r.AgeDays) | $(Escape-Md $d.Problems) |")
    }
}

$md.Add("")
$md.Add("</details>")
$md.Add("")
$md.Add("---")
$md.Add("")
$md.Add("_Denne fil er automatisk genereret fra GitHub Project **Fra idé til færdig løsning** og issue-kommentarer. GitHub Project er den autoritative datakilde; `data/po-overblik-history.json` bruges alene til afledt status-historik. PO-review identificeres via skjulte reviewmarkører i issue-kommentarerne. Kommunikations- og reviewsignaler er indikatorer og skal vurderes af PO._")

# ---------------------------
# Gem
# ---------------------------

$parent = Split-Path -Parent $OutputPath
if (-not [string]::IsNullOrWhiteSpace($parent) -and -not (Test-Path $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
}

[System.IO.File]::WriteAllLines($OutputPath, $md, $Utf8NoBom)

Write-Host ""
Write-Host "PO-overblik genereret." -ForegroundColor Green
Write-Host "Fil: $OutputPath"
Write-Host "Historik: $HistoryPath"
Write-Host "Aktive issues: $($active.Count)"
Write-Host "PO-signaler: $($attentionRows.Count)"
Write-Host "Over 6 måneder: $over6"
Write-Host "Klar til prioritering: $($ready.Count)"
Write-Host ""
Write-Host "Scriptet har kun LÆST fra GitHub. Der er ikke ændret noget i repo, issues eller Project." -ForegroundColor Green
