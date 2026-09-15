param(
    [string]$Repo = "OS2sofd/issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,

    [string]$OutputPath = "docs/leverandoer-overblik.md",
    [string]$HistoryPath = "data/po-overblik-history.json",

    [int]$StatusYellowDays = 30,
    [int]$StatusRedDays = 45,
    [int]$InactiveYellowDays = 14,
    [int]$InactiveRedDays = 30
)

$ErrorActionPreference = "Stop"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom

# ------------------------------------------------------------
# Hjælpefunktioner
# ------------------------------------------------------------

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
        $prop = $Object.PSObject.Properties |
            Where-Object { $_.Name -ieq $name } |
            Select-Object -First 1

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
        $prop = $Object.PSObject.Properties |
            Where-Object { $_.Name -ieq $name } |
            Select-Object -First 1

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

function Escape-Md {
    param([string]$Text)

    if ([string]::IsNullOrWhiteSpace($Text)) { return "–" }

    return (($Text -replace '\|','\|' -replace "`r?`n",' ').Trim())
}

function Issue-Link {
    param(
        [int]$Number,
        [string]$Title,
        [string]$Url
    )

    return "[#$Number – $(Escape-Md $Title)]($Url)"
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

function Get-HistoryEntry {
    param(
        [object]$History,
        [int]$Number
    )

    if ($null -eq $History -or $null -eq $History.issues) {
        return $null
    }

    # Ny state-format bruger "issue-123". Ældre historik kan have "123".
    foreach ($key in @("issue-$Number", [string]$Number)) {
        $prop = $History.issues.PSObject.Properties |
            Where-Object { $_.Name -eq $key } |
            Select-Object -First 1

        if ($null -ne $prop) {
            return $prop.Value
        }
    }

    return $null
}

function Status-Age-Text {
    param(
        [int]$Days,
        [bool]$Known,
        [bool]$Baseline
    )

    if (-not $Known) { return "ukendt" }

    $value = Age-Text $Days
    if ($Baseline) {
        return "≥ $value"
    }

    return $value
}

function Add-Attention {
    param(
        [hashtable]$Table,
        [object]$Row,
        [string]$Signal,
        [string]$Reason,
        [string]$NextAction
    )

    $key = [string]$Row.Number

    if (-not $Table.ContainsKey($key)) {
        $Table[$key] = [PSCustomObject]@{
            Row         = $Row
            Signals     = @()
            Reasons     = @()
            NextActions = @()
        }
    }

    if ($Table[$key].Signals -notcontains $Signal) {
        $Table[$key].Signals += $Signal
    }

    if ($Table[$key].Reasons -notcontains $Reason) {
        $Table[$key].Reasons += $Reason
    }

    if (
        -not [string]::IsNullOrWhiteSpace($NextAction) -and
        $Table[$key].NextActions -notcontains $NextAction
    ) {
        $Table[$key].NextActions += $NextAction
    }
}

# ------------------------------------------------------------
# Forudsætninger
# ------------------------------------------------------------

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) blev ikke fundet."
}

& gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
    throw "GitHub CLI er ikke logget ind. Kør: gh auth login"
}

$tz = [System.TimeZoneInfo]::FindSystemTimeZoneById("Europe/Copenhagen")
$generatedAt = [System.TimeZoneInfo]::ConvertTimeFromUtc([DateTime]::UtcNow, $tz)

$vendorStatuses = @(
    "Afventer løsningsbeskrivelse",
    "Bestilt hos leverandør",
    "Igangværende opgaver",
    "Løsninger i test"
)

$statusOrder = $vendorStatuses

$history = $null
if (Test-Path $HistoryPath) {
    try {
        $history = Get-Content $HistoryPath -Raw | ConvertFrom-Json
    }
    catch {
        Write-Warning "Historikfilen kunne ikke læses. Tid i status vises som ukendt."
    }
}
else {
    Write-Warning "Historikfilen blev ikke fundet: $HistoryPath. Tid i status vises som ukendt."
}

Write-Host ""
Write-Host "OS2sofd leverandøroverblik v1" -ForegroundColor Cyan
Write-Host "Project: $ProjectOwner / #$ProjectNumber"
Write-Host ""

# ------------------------------------------------------------
# Hent Project-data
# ------------------------------------------------------------

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
        $null -ne $_.content.number -and
        (Get-PropertyValue $_ @("status","Status")) -in $vendorStatuses
    }
)

Write-Host "Fundet $($projectItems.Count) issues i leverandørfaser."

# ------------------------------------------------------------
# Hent issue-data
# ------------------------------------------------------------

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

    $createdAt = [DateTimeOffset]::Parse([string]$issue.created_at).LocalDateTime
    $updatedAt = [DateTimeOffset]::Parse([string]$issue.updated_at).LocalDateTime

    $ageDays = [math]::Max(0, [math]::Floor(($generatedAt - $createdAt).TotalDays))
    $inactiveDays = [math]::Max(0, [math]::Floor(($generatedAt - $updatedAt).TotalDays))

    $status = Get-PropertyValue $item @("status","Status")
    $estimate = Get-PropertyValue $item @("Estimat","estimat")
    $releaseInfo = Get-ReleaseInfo $item
    $release = [string]$releaseInfo.Title

    $statusAgeDays = 0
    $statusAgeKnown = $false
    $statusAgeBaseline = $false

    $historyEntry = Get-HistoryEntry $history $n

    if ($null -ne $historyEntry) {
        $historyStatus = [string]$historyEntry.currentStatus
        $historySince = [string]$historyEntry.currentStatusSince

        if (
            $historyStatus -eq $status -and
            -not [string]::IsNullOrWhiteSpace($historySince)
        ) {
            try {
                $statusSince = [DateTimeOffset]::Parse($historySince).LocalDateTime
                $statusAgeDays = [math]::Max(
                    0,
                    [math]::Floor(($generatedAt - $statusSince).TotalDays)
                )
                $statusAgeKnown = $true
                $statusAgeBaseline = [bool]$historyEntry.currentStatusIsBaseline
            }
            catch {
                $statusAgeKnown = $false
            }
        }
    }

    $rows += [PSCustomObject]@{
        Number            = $n
        Title             = [string]$issue.title
        Url               = [string]$issue.html_url
        Status            = $status
        CreatedAt         = $createdAt
        UpdatedAt         = $updatedAt
        AgeDays           = [int]$ageDays
        InactiveDays      = [int]$inactiveDays
        Estimate          = $estimate
        Release           = $release
        ReleaseEnd        = $releaseInfo.End
        StatusAgeDays     = [int]$statusAgeDays
        StatusAgeKnown    = [bool]$statusAgeKnown
        StatusAgeBaseline = [bool]$statusAgeBaseline
    }
}

Write-Progress -Activity "Henter GitHub-data" -Completed

# ------------------------------------------------------------
# Analyse: 1. flow og omløbstid
# ------------------------------------------------------------

$near6 = @($rows | Where-Object { $_.AgeDays -ge 137 -and $_.AgeDays -le 183 })
$over6 = @($rows | Where-Object { $_.AgeDays -gt 183 })

$flowRows = @()

foreach ($status in $statusOrder) {
    $stage = @($rows | Where-Object { $_.Status -eq $status })

    if ($stage.Count -eq 0) {
        $flowRows += [PSCustomObject]@{
            Status          = $status
            Count           = 0
            MedianStatusAge = 0
            OldestStatusAge = 0
            Over30          = 0
            Near6           = 0
            Over6           = 0
        }
        continue
    }

    $knownStatusAges = @(
        $stage |
        Where-Object { $_.StatusAgeKnown } |
        ForEach-Object { [double]$_.StatusAgeDays }
    )

    $medianStatusAge = 0
    $oldestStatusAge = 0

    if ($knownStatusAges.Count -gt 0) {
        $medianStatusAge = [int][math]::Round((Median $knownStatusAges),0)
        $oldestStatusAge = [int](($knownStatusAges | Measure-Object -Maximum).Maximum)
    }

    $flowRows += [PSCustomObject]@{
        Status          = $status
        Count           = $stage.Count
        MedianStatusAge = $medianStatusAge
        OldestStatusAge = $oldestStatusAge
        Over30          = @($stage | Where-Object { $_.StatusAgeKnown -and $_.StatusAgeDays -gt $StatusYellowDays }).Count
        Near6           = @($stage | Where-Object { $_.AgeDays -ge 137 -and $_.AgeDays -le 183 }).Count
        Over6           = @($stage | Where-Object { $_.AgeDays -gt 183 }).Count
    }
}

# ------------------------------------------------------------
# Analyse: 2. gennemsigtighed
# ------------------------------------------------------------

$attention = @{}
$transparencyRows = @()

foreach ($r in $rows) {
    # Omløbstid / tid i status
    if ($r.AgeDays -gt 183) {
        Add-Attention $attention $r "🔴" "GitHub-alderen er over 6 måneder" "Afklar konkret plan og næste skridt"
    }
    elseif ($r.AgeDays -ge 137) {
        Add-Attention $attention $r "🟠" "GitHub-alderen er 4,5–6 måneder" "Vurder risiko for at overskride 6-månedersmålet"
    }

    if ($r.StatusAgeKnown) {
        if ($r.StatusAgeDays -gt $StatusRedDays) {
            Add-Attention $attention $r "🔴" "$($r.StatusAgeDays) dage i samme status" "Afklar blokering og næste handling"
        }
        elseif ($r.StatusAgeDays -gt $StatusYellowDays) {
            Add-Attention $attention $r "🟡" "$($r.StatusAgeDays) dage i samme status" "Vurder fremdrift og næste handling"
        }
    }

    # Gennemsigtighed
    if ($r.Status -eq "Afventer løsningsbeskrivelse") {
        if ($r.InactiveDays -gt $InactiveRedDays) {
            $transparencyRows += [PSCustomObject]@{
                Row = $r
                Signal = "🔴"
                Problem = "Ingen registreret opdatering i $($r.InactiveDays) dage"
                NextAction = "Status/afklaring opdateres"
            }
            Add-Attention $attention $r "🔴" "Ingen registreret opdatering i $($r.InactiveDays) dage" "Status/afklaring opdateres"
        }
        elseif ($r.InactiveDays -gt $InactiveYellowDays) {
            $transparencyRows += [PSCustomObject]@{
                Row = $r
                Signal = "🟡"
                Problem = "Ingen registreret opdatering i $($r.InactiveDays) dage"
                NextAction = "Status/afklaring opdateres"
            }
            Add-Attention $attention $r "🟡" "Ingen registreret opdatering i $($r.InactiveDays) dage" "Status/afklaring opdateres"
        }

        if (
            [string]::IsNullOrWhiteSpace($r.Estimate) -and
            $r.StatusAgeKnown -and
            $r.StatusAgeDays -gt $InactiveYellowDays
        ) {
            $transparencyRows += [PSCustomObject]@{
                Row = $r
                Signal = "🟡"
                Problem = "Estimat mangler efter mere end $InactiveYellowDays dage i status"
                NextAction = "Estimat eller årsag til manglende estimat registreres"
            }
            Add-Attention $attention $r "🟡" "Estimat mangler" "Estimat eller årsag til manglende estimat registreres"
        }
    }

    if ($r.Status -eq "Bestilt hos leverandør") {
        if ([string]::IsNullOrWhiteSpace($r.Release)) {
            $transparencyRows += [PSCustomObject]@{
                Row = $r
                Signal = "🔴"
                Problem = "Planlagt release mangler"
                NextAction = "Planlagt release angives"
            }
            Add-Attention $attention $r "🔴" "Planlagt release mangler" "Planlagt release angives"
        }
    }

    if ($r.Status -eq "Igangværende opgaver") {
        if ($r.InactiveDays -gt $InactiveYellowDays) {
            $signal = "🟡"
            if ($r.InactiveDays -gt $InactiveRedDays) { $signal = "🔴" }

            $transparencyRows += [PSCustomObject]@{
                Row = $r
                Signal = $signal
                Problem = "Ingen registreret opdatering i $($r.InactiveDays) dage"
                NextAction = "Fremdrift eller blokering opdateres"
            }
            Add-Attention $attention $r $signal "Ingen registreret opdatering i $($r.InactiveDays) dage" "Fremdrift eller blokering opdateres"
        }
    }

    if ($r.Status -eq "Løsninger i test") {
        if ($r.InactiveDays -gt $InactiveYellowDays) {
            $signal = "🟡"
            if ($r.InactiveDays -gt $InactiveRedDays) { $signal = "🔴" }

            $transparencyRows += [PSCustomObject]@{
                Row = $r
                Signal = $signal
                Problem = "Ingen registreret opdatering i $($r.InactiveDays) dage"
                NextAction = "Teststatus og næste handling afklares"
            }
            Add-Attention $attention $r $signal "Ingen registreret opdatering i $($r.InactiveDays) dage" "Teststatus og næste handling afklares"
        }
    }
}

# ------------------------------------------------------------
# Markdown
# ------------------------------------------------------------

$md = New-Object System.Collections.Generic.List[string]

$md.Add("# Leverandøroverblik – OS2sofd")
$md.Add("")
$md.Add("> **Formål:** fælles og leverandørneutralt styringsblik på leverandørdelen af ændringsprocessen med fokus på **1) omløbstid** og **2) gennemsigtighed**.")
$md.Add("")
$md.Add("Senest genereret: **$($generatedAt.ToString("dd-MM-yyyy HH:mm"))**  ")
$md.Add("Målsætning for samlet omløbstid: **maks. 6 måneder fra idé til færdig løsning**")
$md.Add("")
$md.Add("Følgende faser indgår i v1:")
$md.Add("")
$md.Add("- Afventer løsningsbeskrivelse")
$md.Add("- Bestilt hos leverandør")
$md.Add("- Igangværende opgaver")
$md.Add("- Løsninger i test")
$md.Add("")
$md.Add("> **Løsninger i review indgår ikke i v1.** Fasen afventer nærmere afklaring og definition af ansvar, test, accept og næste handling.")
$md.Add("")
$md.Add("> **Om alder:** samlet alder beregnes fra GitHub-issuets oprettelsesdato. Migrerede ønsker kan derfor reelt være ældre.")
$md.Add("")
$md.Add("> **Om tid i status:** `≥` betyder, at issuet allerede stod i status, da historikmålingen begyndte. Den reelle tid i status kan derfor være længere.")
$md.Add("")
$md.Add("> **Om 'senest opdateret':** GitHubs `updated_at` bruges som indikator. Det er en proxy og er ikke nødvendigvis det samme som en faglig statusopdatering.")
$md.Add("")
$md.Add("---")
$md.Add("")

# Top: kræver opmærksomhed
$md.Add("## Kræver fælles opmærksomhed")
$md.Add("")

$attentionRows = @(
    $attention.Values |
    Sort-Object `
        @{Expression={
            if ($_.Signals -contains "🔴") { 1 }
            elseif ($_.Signals -contains "🟠") { 2 }
            else { 3 }
        }; Ascending=$true},
        @{Expression={ $_.Row.AgeDays }; Descending=$true}
)

if ($attentionRows.Count -eq 0) {
    $md.Add("Ingen leverandørsager udløser de aktuelle v1-signaler.")
}
else {
    $md.Add("| Signal | Issue | Status | Tid i status | Samlet GitHub-alder | Opmærksomhed | Næste handling |")
    $md.Add("| --- | --- | --- | ---: | ---: | --- | --- |")

    foreach ($a in $attentionRows) {
        $r = $a.Row

        $signal = "🟡"
        if ($a.Signals -contains "🔴") {
            $signal = "🔴"
        }
        elseif ($a.Signals -contains "🟠") {
            $signal = "🟠"
        }

        $reason = ($a.Reasons -join "; ")
        $next = ($a.NextActions -join "; ")

        $md.Add("| $signal | $(Issue-Link $r.Number $r.Title $r.Url) | $(Escape-Md $r.Status) | $(Status-Age-Text $r.StatusAgeDays $r.StatusAgeKnown $r.StatusAgeBaseline) | $(Age-Text $r.AgeDays) | $(Escape-Md $reason) | $(Escape-Md $next) |")
    }
}

$md.Add("")
$md.Add("---")
$md.Add("")

# 1
$md.Add("## 1. Flow og omløbstid")
$md.Add("")
$md.Add("Aktive sager i leverandørfaser: **$($rows.Count)**  ")
$md.Add("GitHub-alder 4,5–6 måneder: **$($near6.Count)**  ")
$md.Add("GitHub-alder over 6 måneder: **$($over6.Count)**")
$md.Add("")
$md.Add("| Status | Antal | Median observeret tid i status | Ældste observerede tid i status | >$StatusYellowDays dage i status | 4,5–6 mdr. samlet alder | >6 mdr. samlet alder |")
$md.Add("| --- | ---: | ---: | ---: | ---: | ---: | ---: |")

foreach ($f in $flowRows) {
    $medianText = "–"
    $oldestText = "–"

    if ($f.Count -gt 0) {
        $knownCount = @($rows | Where-Object { $_.Status -eq $f.Status -and $_.StatusAgeKnown }).Count
        if ($knownCount -gt 0) {
            $medianText = Age-Text $f.MedianStatusAge
            $oldestText = Age-Text $f.OldestStatusAge
        }
    }

    $md.Add("| $(Escape-Md $f.Status) | $($f.Count) | $medianText | $oldestText | $($f.Over30) | $($f.Near6) | $($f.Over6) |")
}

$md.Add("")
$md.Add("---")
$md.Add("")

# 2
$md.Add("## 2. Gennemsigtighed")
$md.Add("")
$md.Add("Denne sektion viser kun undtagelser – dvs. sager hvor en forventet oplysning eller opdatering mangler.")
$md.Add("")

if ($transparencyRows.Count -eq 0) {
    $md.Add("Ingen sager udløser de aktuelle v1-regler for gennemsigtighed.")
}
else {
    $transparencyRows = @(
        $transparencyRows |
        Sort-Object `
            @{Expression={ if ($_.Signal -eq "🔴") { 1 } else { 2 } }; Ascending=$true},
            @{Expression={ $_.Row.AgeDays }; Descending=$true}
    )

    $md.Add("| Signal | Issue | Status | Problem | Næste handling |")
    $md.Add("| --- | --- | --- | --- | --- |")

    foreach ($x in $transparencyRows) {
        $r = $x.Row
        $md.Add("| $($x.Signal) | $(Issue-Link $r.Number $r.Title $r.Url) | $(Escape-Md $r.Status) | $(Escape-Md $x.Problem) | $(Escape-Md $x.NextAction) |")
    }
}

$md.Add("")
$md.Add("### Regler i v1")
$md.Add("")
$md.Add("- 🟡 Mere end **$StatusYellowDays dage** i samme leverandørstatus.")
$md.Add("- 🔴 Mere end **$StatusRedDays dage** i samme leverandørstatus.")
$md.Add("- `Afventer løsningsbeskrivelse`: manglende registreret opdatering efter **$InactiveYellowDays dage**; rødt efter **$InactiveRedDays dage**.")
$md.Add("- `Afventer løsningsbeskrivelse`: manglende estimat markeres, når sagen har stået mere end **$InactiveYellowDays dage** i status.")
$md.Add("- `Bestilt hos leverandør`: planlagt release skal være angivet.")
$md.Add("- `Igangværende opgaver`: manglende registreret opdatering efter **$InactiveYellowDays dage**.")
$md.Add("- `Løsninger i test`: manglende registreret opdatering efter **$InactiveYellowDays dage**.")
$md.Add("")
$md.Add("---")
$md.Add("")
$md.Add("_Rapporten er et fælles proces- og styringsblik. Den måler ikke kodekvalitet eller placerer automatisk ansvar for en forsinkelse. GitHub Project er den autoritative datakilde._")

$parent = Split-Path -Parent $OutputPath
if (-not [string]::IsNullOrWhiteSpace($parent) -and -not (Test-Path $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
}

[System.IO.File]::WriteAllLines($OutputPath, $md, $Utf8NoBom)

Write-Host ""
Write-Host "Leverandøroverblik genereret." -ForegroundColor Green
Write-Host "Fil: $OutputPath"
