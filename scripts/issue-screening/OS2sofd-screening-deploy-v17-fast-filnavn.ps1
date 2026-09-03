param(
    [ValidateSet("DryRun","Apply")]
    [string]$Mode = "DryRun",

    [int[]]$Issues = @(),

    [string]$PackagePath = (Join-Path $env:USERPROFILE "Downloads\OS2sofd-screening-resultat-aktuel.json"),

    [string]$Repo = "OS2sofd/issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,

    [string]$SupplierMention = "@OS2sofd/leverandor-digital-identity",

    [int]$BatchSize = 20,
    [int]$MinGraphqlRemaining = 100,
    [int]$MinCoreRemaining = 300,
    [int]$PauseBetweenIssuesMilliseconds = 200
)

# Windows PowerShell 5.1 + GitHub CLI: brug UTF-8.
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom
$ErrorActionPreference = "Stop"

$MarkerPrefix = "<!-- os2sofd-screening-v3 issue:"
$PriorityMarkerPrefix = "<!-- os2sofd-priority-review-v1 issue:"

function Run-GhJson {
    param([string[]]$GhArgs)

    $errFile = Join-Path $env:TEMP ("os2sofd-gh-err-" + [guid]::NewGuid().ToString() + ".txt")
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

function Run-Gh {
    param([string[]]$GhArgs)

    $errFile = Join-Path $env:TEMP ("os2sofd-gh-err-" + [guid]::NewGuid().ToString() + ".txt")
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

        return $output
    }
    finally {
        Remove-Item $errFile -ErrorAction SilentlyContinue
    }
}

function Write-JsonTempFile {
    param(
        [object]$Object,
        [string]$Prefix = "os2sofd"
    )

    $path = Join-Path $env:TEMP ("$Prefix-" + [guid]::NewGuid().ToString() + ".json")
    $json = $Object | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($path, $json, $Utf8NoBom)
    return $path
}

function Get-RateState {
    $rate = Run-GhJson @("api","rate_limit")

    [PSCustomObject]@{
        GraphqlLimit = [int]$rate.resources.graphql.limit
        GraphqlRemaining = [int]$rate.resources.graphql.remaining
        GraphqlReset = [DateTimeOffset]::FromUnixTimeSeconds([int64]$rate.resources.graphql.reset).ToLocalTime()

        CoreLimit = [int]$rate.resources.core.limit
        CoreRemaining = [int]$rate.resources.core.remaining
        CoreReset = [DateTimeOffset]::FromUnixTimeSeconds([int64]$rate.resources.core.reset).ToLocalTime()
    }
}

function Show-RateState {
    param([object]$Rate)

    Write-Host ("GraphQL: {0}/{1} tilbage - reset {2:HH:mm:ss}" -f `
        $Rate.GraphqlRemaining, $Rate.GraphqlLimit, $Rate.GraphqlReset) -ForegroundColor Cyan

    Write-Host ("REST/Core: {0}/{1} tilbage - reset {2:HH:mm:ss}" -f `
        $Rate.CoreRemaining, $Rate.CoreLimit, $Rate.CoreReset) -ForegroundColor Cyan
}

function Test-RateSafe {
    param([object]$Rate)

    return (
        $Rate.GraphqlRemaining -gt $MinGraphqlRemaining -and
        $Rate.CoreRemaining -gt $MinCoreRemaining
    )
}

function Get-ProjectFieldValue {
    param(
        [object]$ProjectItem,
        [string[]]$CandidateNames
    )

    foreach ($name in $CandidateNames) {
        $prop = $ProjectItem.PSObject.Properties[$name]
        if ($null -ne $prop -and $null -ne $prop.Value -and -not [string]::IsNullOrWhiteSpace([string]$prop.Value)) {
            return [string]$prop.Value
        }
    }

    return ""
}

function Get-IssueRest {
    param([int]$Number)
    return Run-GhJson @("api","repos/$Repo/issues/$Number")
}

function Get-IssueCommentsRest {
    param([int]$Number)
    return @(Run-GhJson @("api","repos/$Repo/issues/$Number/comments?per_page=100"))
}

function Add-IssueCommentRest {
    param(
        [int]$Number,
        [string]$Body
    )

    $temp = Write-JsonTempFile -Prefix "os2sofd-comment" -Object ([PSCustomObject]@{ body = $Body })
    try {
        Run-Gh @("api","--method","POST","repos/$Repo/issues/$Number/comments","--input",$temp) | Out-Null
    }
    finally {
        Remove-Item $temp -ErrorAction SilentlyContinue
    }
}

function Add-IssueLabelsRest {
    param(
        [int]$Number,
        [string[]]$Labels
    )

    if ($Labels.Count -eq 0) { return }

    $temp = Write-JsonTempFile -Prefix "os2sofd-labels" -Object ([PSCustomObject]@{ labels = @($Labels) })
    try {
        Run-Gh @("api","--method","POST","repos/$Repo/issues/$Number/labels","--input",$temp) | Out-Null
    }
    finally {
        Remove-Item $temp -ErrorAction SilentlyContinue
    }
}

function Remove-IssueLabelRest {
    param(
        [int]$Number,
        [string]$Label
    )

    $encodedLabel = [uri]::EscapeDataString($Label)
    Run-Gh @("api","--method","DELETE","repos/$Repo/issues/$Number/labels/$encodedLabel") | Out-Null
}

function Set-ProjectSingleSelectFieldsOptimized {
    param(
        [string]$ProjectId,
        [string]$ItemId,
        [object[]]$Updates
    )

    if ($Updates.Count -eq 0) { return }

    # Ét GraphQL-request pr. issue, selv hvis både Status og Prioritet skal ændres.
    $varDefs = @('$projectId:ID!', '$itemId:ID!')
    $variables = @{
        projectId = $ProjectId
        itemId = $ItemId
    }

    $mutationLines = New-Object System.Collections.Generic.List[string]

    for ($i = 0; $i -lt $Updates.Count; $i++) {
        $u = $Updates[$i]
        $idx = $i + 1

        $fieldVar = "field$idx"
        $optionVar = "option$idx"

        $varDefs += "`$$fieldVar`:ID!"
        $varDefs += "`$$optionVar`:String!"

        $variables[$fieldVar] = [string]$u.FieldId
        $variables[$optionVar] = [string]$u.OptionId

        $mutationLines.Add(@"
u$idx`: updateProjectV2ItemFieldValue(input:{
  projectId:`$projectId,
  itemId:`$itemId,
  fieldId:`$$fieldVar,
  value:{singleSelectOptionId:`$$optionVar}
}) {
  projectV2Item { id }
}
"@) | Out-Null
    }

    $query = "mutation(" + ($varDefs -join ",") + ") {" + "`n" + ($mutationLines -join "`n") + "`n}"

    $args = @("api","graphql","-f","query=$query")
    foreach ($key in $variables.Keys) {
        $args += @("-F", "$key=$($variables[$key])")
    }

    Run-GhJson $args | Out-Null
}



function Get-IssueFormValue {
    param(
        [string]$Body,
        [string]$Heading
    )

    if ([string]::IsNullOrWhiteSpace($Body)) { return "" }

    $escaped = [regex]::Escape($Heading)
    $pattern = "(?ms)^###\s+$escaped\s*\r?\n\r?\n(.*?)(?=^###\s+|\z)"
    $m = [regex]::Match($Body, $pattern)

    if (-not $m.Success) { return "" }

    $value = ($m.Groups[1].Value -split "\r?\n")[0].Trim()

    if (
        [string]::IsNullOrWhiteSpace($value) -or
        $value -match '^_?No response_?$' -or
        $value -eq '-'
    ) {
        return ""
    }

    return $value
}

function Set-ProjectFieldsOptimized {
    param(
        [string]$ProjectId,
        [string]$ItemId,
        [object[]]$SingleSelectUpdates,
        [object[]]$TextUpdates
    )

    if ($SingleSelectUpdates.Count -eq 0 -and $TextUpdates.Count -eq 0) { return }

    $varDefs = @('$projectId:ID!', '$itemId:ID!')
    $variables = @{
        projectId = $ProjectId
        itemId = $ItemId
    }

    $mutationLines = New-Object System.Collections.Generic.List[string]
    $idx = 0

    foreach ($u in $SingleSelectUpdates) {
        $idx++
        $fieldVar = "field$idx"
        $optionVar = "option$idx"

        $varDefs += "`$$fieldVar`:ID!"
        $varDefs += "`$$optionVar`:String!"

        $variables[$fieldVar] = [string]$u.FieldId
        $variables[$optionVar] = [string]$u.OptionId

        $mutationLines.Add(@"
u$idx`: updateProjectV2ItemFieldValue(input:{
  projectId:`$projectId,
  itemId:`$itemId,
  fieldId:`$$fieldVar,
  value:{singleSelectOptionId:`$$optionVar}
}) {
  projectV2Item { id }
}
"@) | Out-Null
    }

    foreach ($u in $TextUpdates) {
        $idx++
        $fieldVar = "field$idx"
        $valueVar = "value$idx"

        $varDefs += "`$$fieldVar`:ID!"
        $varDefs += "`$$valueVar`:String!"

        $variables[$fieldVar] = [string]$u.FieldId
        $variables[$valueVar] = [string]$u.Value

        $mutationLines.Add(@"
u$idx`: updateProjectV2ItemFieldValue(input:{
  projectId:`$projectId,
  itemId:`$itemId,
  fieldId:`$$fieldVar,
  value:{text:`$$valueVar}
}) {
  projectV2Item { id }
}
"@) | Out-Null
    }

    $query = "mutation(" + ($varDefs -join ",") + ") {" + "`n" + ($mutationLines -join "`n") + "`n}"

    $args = @("api","graphql","-f","query=$query")
    foreach ($key in $variables.Keys) {
        $args += @("-F", "$key=$($variables[$key])")
    }

    Run-GhJson $args | Out-Null
}

function Convert-CommentForReturnFlow {
    param([string]$Body)

    $replacement = @"
### Prioritet

Prioriteten behandles først, når de nødvendige afklaringer fra opretter foreligger.
"@

    return [regex]::Replace(
        $Body,
        '(?ms)\r?\n### Prioritet\r?\n.*?(?=\r?\n### Kategorisering)',
        "`n$replacement`n"
    )
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) blev ikke fundet."
}

if (-not (Test-Path $PackagePath)) {
    throw "Kan ikke finde deployment-filen: $PackagePath"
}

& gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
    throw "GitHub CLI er ikke logget ind. Kør: gh auth login"
}

$parsedPackage = Get-Content $PackagePath -Raw -Encoding UTF8 | ConvertFrom-Json
$package = @()
foreach ($entry in $parsedPackage) {
    $package += $entry
}

if ($Issues.Count -eq 0) {
    $selected = @($package | Sort-Object { [int]$_.number })
} else {
    $selected = @(
        $package |
        Where-Object { [int]$_.number -in $Issues } |
        Sort-Object { [int]$_.number }
    )

    $selectedNumbers = @($selected | ForEach-Object { [int]$_.number })
    $missing = @($Issues | Where-Object { [int]$_ -notin $selectedNumbers })

    if ($missing.Count -gt 0) {
        throw "Disse issues findes ikke i deployment-filen: $($missing -join ', ')"
    }
}

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$logPath = Join-Path $PSScriptRoot "OS2sofd-screening-v12-$Mode-$stamp.csv"
$completedPath = Join-Path $PSScriptRoot "OS2sofd-screening-v12-completed-$Mode-$stamp.txt"
$incompletePath = Join-Path $PSScriptRoot "OS2sofd-screening-v12-not-completed-$Mode-$stamp.txt"

$log = New-Object System.Collections.ArrayList
$completedNumbers = New-Object System.Collections.ArrayList

function Save-RunState {
    $log | Export-Csv $logPath -NoTypeInformation -Encoding UTF8

    $completedText = @($completedNumbers | Sort-Object -Unique) -join ","
    [System.IO.File]::WriteAllText($completedPath, $completedText, $Utf8NoBom)

    $incomplete = @($selected.number | Where-Object { [int]$_ -notin @($completedNumbers) })
    $incompleteText = @($incomplete | Sort-Object -Unique) -join ","
    [System.IO.File]::WriteAllText($incompletePath, $incompleteText, $Utf8NoBom)
}

Write-Host ""
Write-Host "OS2sofd screening deployment v17 FAST FILNAVN - $Mode" -ForegroundColor Cyan
Write-Host "Antal valgte issues: $($selected.Count)"
Write-Host ""

$rate = Get-RateState
Show-RateState $rate

if (-not (Test-RateSafe $rate)) {
    Write-Host ""
    Write-Host "STOP: API-kvoten er for lav til at starte sikkert." -ForegroundColor Yellow
    Write-Host ("GraphQL reset: {0:dd-MM-yyyy HH:mm:ss}" -f $rate.GraphqlReset)
    Write-Host ("REST reset:    {0:dd-MM-yyyy HH:mm:ss}" -f $rate.CoreReset)
    Save-RunState
    return
}

# Repo-labels via REST.
$repoLabels = Run-GhJson @("api","repos/$Repo/labels?per_page=100")
$repoLabelNames = @($repoLabels | ForEach-Object { $_.name })

# Project metadata læses én gang.
$projectInfo = Run-GhJson @(
    "project","view","$ProjectNumber",
    "--owner",$ProjectOwner,
    "--format","json"
)
$projectId = [string]$projectInfo.id

$fieldInfo = Run-GhJson @(
    "project","field-list","$ProjectNumber",
    "--owner",$ProjectOwner,
    "--format","json"
)

$projectFields = @{}
foreach ($f in $fieldInfo.fields) {
    $projectFields[[string]$f.name] = $f
}

foreach ($requiredField in @("Status","Prioritet","Kontakt","Kommune","JIRA-Id")) {
    if (-not $projectFields.ContainsKey($requiredField)) {
        throw "Project-feltet '$requiredField' blev ikke fundet."
    }
}

$statusFieldId = [string]$projectFields["Status"].id
$priorityFieldId = [string]$projectFields["Prioritet"].id
$contactFieldId = [string]$projectFields["Kontakt"].id
$municipalityFieldId = [string]$projectFields["Kommune"].id
$jiraFieldId = [string]$projectFields["JIRA-Id"].id

$statusOptions = @{}
foreach ($o in $projectFields["Status"].options) {
    $statusOptions[[string]$o.name] = [string]$o.id
}

$priorityOptions = @{}
foreach ($o in $projectFields["Prioritet"].options) {
    $priorityOptions[[string]$o.name] = [string]$o.id
}

$projectData = Run-GhJson @(
    "project","item-list","$ProjectNumber",
    "--owner",$ProjectOwner,
    "--limit","200",
    "--format","json"
)
$projectItems = @($projectData.items)

$stopRequested = $false
$stopReason = ""

for ($batchStart = 0; $batchStart -lt $selected.Count; $batchStart += $BatchSize) {
    $batchEnd = [Math]::Min($batchStart + $BatchSize - 1, $selected.Count - 1)
    $batch = @($selected[$batchStart..$batchEnd])
    $batchNo = [int]([Math]::Floor($batchStart / $BatchSize) + 1)

    Write-Host ""
    Write-Host "========== Batch $batchNo ==========" -ForegroundColor Magenta

    $rate = Get-RateState
    Show-RateState $rate

    if (-not (Test-RateSafe $rate)) {
        $stopRequested = $true
        $stopReason = "API-kvoten er under sikkerhedsgrænsen."
        break
    }

    foreach ($item in $batch) {
        $n = [int]$item.number
        $url = [string]$item.url

        $marker = "$MarkerPrefix$n -->"
        $priorityMarker = "$PriorityMarkerPrefix$n -->"

        $actions = New-Object System.Collections.Generic.List[string]
        $result = "NotStarted"
        $errorText = ""

        Write-Host ""
        Write-Host "Issue #$n - $($item.title)" -ForegroundColor Yellow

        try {
            $rate = Get-RateState
            if (-not (Test-RateSafe $rate)) {
                throw "API-kvoten er under sikkerhedsgrænsen før næste issue."
            }

            # REST: issue + kommentarer.
            $issue = Get-IssueRest -Number $n
            $comments = Get-IssueCommentsRest -Number $n

            $currentLabels = @($issue.labels | ForEach-Object { $_.name })
            $existingComments = @($comments | ForEach-Object { $_.body })

            $commentAlreadyExists = ($existingComments | Where-Object { $_ -like "*$marker*" }).Count -gt 0
            $priorityReviewCommentAlreadyExists = ($existingComments | Where-Object { $_ -like "*$priorityMarker*" }).Count -gt 0

            $creatorMention = ""
            if ($issue.user -and $issue.user.login) {
                $creatorMention = "@$($issue.user.login)"
            }

            $labelsToAdd = @($item.labelsToAdd | Where-Object { $_ -and ($_ -notin $currentLabels) })
            $missingLabels = @($item.labelsToAdd | Where-Object { $_ -and ($_ -notin $repoLabelNames) })
            $removeChangeRequestLabel = "ændringsønske" -in $currentLabels

            $matches = @($projectItems | Where-Object { $_.content.url -eq $url })
            if ($matches.Count -eq 0) {
                throw "Issue findes ikke i Project."
            }

            $projectItem = $matches[0]
            $projectItemId = [string]$projectItem.id

            if ([string]::IsNullOrWhiteSpace($projectItemId)) {
                throw "Project item-ID mangler."
            }

            $currentStatus = [string]$projectItem.status
            $targetStatus = [string]$item.targetProjectStatus

            $isReturnFlow = (
                [string]$item.screeningDecision -eq "Returnér til opretter" -or
                $targetStatus -eq "Screening"
            )

            # Sikkerhedsregel: retur-sager skal altid blive i Screening.
            if ($isReturnFlow) {
                $targetStatus = "Screening"
            }

            $currentPriority = Get-ProjectFieldValue `
                -ProjectItem $projectItem `
                -CandidateNames @("prioritet","Prioritet","priority","Priority")

            $targetPriority = [string]$item.statedPriority
            $autoApplyPriority = [bool]$item.autoApplyPriority
            $priorityAssessment = [string]$item.priorityAssessment

            # Project-tekstfelter hentes direkte fra den aktuelle issue-formular.
            $sourceContact = Get-IssueFormValue -Body ([string]$issue.body) -Heading "Navn"
            $sourceMunicipality = Get-IssueFormValue -Body ([string]$issue.body) -Heading "Kommune"
            $sourceJira = Get-IssueFormValue -Body ([string]$issue.body) -Heading "JIRA ID (hvis relevant)"

            $currentContact = Get-ProjectFieldValue -ProjectItem $projectItem -CandidateNames @("kontakt","Kontakt")
            $currentMunicipality = Get-ProjectFieldValue -ProjectItem $projectItem -CandidateNames @("kommune","Kommune")
            $currentJira = Get-ProjectFieldValue -ProjectItem $projectItem -CandidateNames @("jira-id","JIRA-Id","jiraId","JIRAId")

            Write-Host "  Status:         $currentStatus -> $targetStatus"

            if ($isReturnFlow) {
                Write-Host "  Prioritet:      UDSKUDT - afventer svar fra opretter"
                Write-Host "  Leverandør:     pinges ikke"
            }
            elseif ($autoApplyPriority) {
                if ([string]::IsNullOrWhiteSpace($currentPriority)) {
                    Write-Host "  Prioritet:      (tom) -> $targetPriority"
                } elseif ($currentPriority -eq $targetPriority) {
                    Write-Host "  Prioritet:      $currentPriority (allerede korrekt)"
                } else {
                    Write-Host "  Prioritet:      $currentPriority beholdes; oplyst er $targetPriority" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  Prioritet:      MANUEL VURDERING" -ForegroundColor Yellow
                Write-Host "  PO-ping:        @erlingpoulsen"
            }


            foreach ($pf in @(
                [PSCustomObject]@{Name="Kontakt"; Current=$currentContact; Source=$sourceContact},
                [PSCustomObject]@{Name="Kommune"; Current=$currentMunicipality; Source=$sourceMunicipality},
                [PSCustomObject]@{Name="JIRA-Id"; Current=$currentJira; Source=$sourceJira}
            )) {
                if ([string]::IsNullOrWhiteSpace([string]$pf.Source)) {
                    Write-Host "  $($pf.Name):         ingen værdi i ændringsønsket"
                }
                elseif ([string]::IsNullOrWhiteSpace([string]$pf.Current)) {
                    Write-Host "  $($pf.Name):         (tom) -> '$($pf.Source)'"
                }
                elseif ([string]$pf.Current -eq [string]$pf.Source) {
                    Write-Host "  $($pf.Name):         '$($pf.Current)' (allerede korrekt)"
                }
                else {
                    Write-Host "  $($pf.Name):         '$($pf.Current)' beholdes; kildeværdi er '$($pf.Source)'" -ForegroundColor Yellow
                }
            }

            if ($missingLabels.Count -gt 0) {
                throw "Manglende repo-labels: $($missingLabels -join ', ')"
            }

            if ([string]::IsNullOrWhiteSpace($creatorMention)) {
                throw "Kunne ikke finde issue-opretter."
            }

            if ($Mode -eq "DryRun") {
                $result = "DryRunOK"
            }
            else {
                # 1) Kommentar via REST.
                if (-not $commentAlreadyExists) {
                    if ($isReturnFlow) {
                        $baseCommentBody = Convert-CommentForReturnFlow -Body ([string]$item.commentBody)

                        $processText = @"

### Videre i processen

$creatorMention Vi mangler lidt flere oplysninger, før ændringsønsket kan gå videre. Har du mulighed for at svare på spørgsmålene ovenfor?
"@
                    }
                    else {
                        $baseCommentBody = [string]$item.commentBody

                        $processText = @"

### Videre i processen

$creatorMention Tak for ændringsønsket. Screeningen er afsluttet, og ønsket går nu videre til **Afventer løsningsbeskrivelse**.

$SupplierMention Ændringsønsket er klar til, at der kan udarbejdes et konkret løsningsforslag og estimat. Tag gerne den nødvendige dialog med opretter undervejs.
"@
                    }

                    Add-IssueCommentRest -Number $n -Body "$baseCommentBody$processText`n`n$marker`n"
                    $actions.Add("Screeningskommentar oprettet") | Out-Null
                    Write-Host "  OK: screeningskommentar oprettet" -ForegroundColor Green
                }

                # 2) Labels via REST.
                if ($labelsToAdd.Count -gt 0) {
                    Add-IssueLabelsRest -Number $n -Labels $labelsToAdd
                    $actions.Add("Labels tilføjet: $($labelsToAdd -join ', ')") | Out-Null
                    Write-Host "  OK: labels tilføjet" -ForegroundColor Green
                }

                if ($removeChangeRequestLabel) {
                    Remove-IssueLabelRest -Number $n -Label "ændringsønske"
                    $actions.Add("Label ændringsønske fjernet") | Out-Null
                    Write-Host "  OK: label 'ændringsønske' fjernet" -ForegroundColor Green
                }

                # 3) PO-kommentar ved manuel prioritet via REST.
                if (-not $isReturnFlow -and -not $autoApplyPriority -and -not $priorityReviewCommentAlreadyExists) {
                    $priorityReviewBody = @"
### Prioritet kræver manuel vurdering

@erlingpoulsen Den oplyste prioritet er **$targetPriority**, men screeningen vurderer ikke prioriteringsgrundlaget som tilstrækkeligt sikkert til automatisk overførsel.

**Screening:** $priorityAssessment

Prioritetsfeltet er derfor ikke ændret automatisk.

$priorityMarker
"@
                    Add-IssueCommentRest -Number $n -Body $priorityReviewBody
                    $actions.Add("PO-kommentar om prioritet oprettet") | Out-Null
                    Write-Host "  OK: PO-kommentar oprettet" -ForegroundColor Green
                }

                # 4) Status, evt. prioritet samt Kontakt/Kommune/JIRA-Id samles i ÉT GraphQL-request.
                $projectUpdates = @()
                $projectTextUpdates = @()

                if ($currentStatus -ne $targetStatus) {
                    if (-not $statusOptions.ContainsKey($targetStatus)) {
                        throw "Statusværdien '$targetStatus' findes ikke i Project."
                    }

                    $projectUpdates += [PSCustomObject]@{
                        Name = "Status"
                        FieldId = $statusFieldId
                        OptionId = $statusOptions[$targetStatus]
                    }
                }

                if (
                    -not $isReturnFlow -and
                    $autoApplyPriority -and
                    -not [string]::IsNullOrWhiteSpace($targetPriority) -and
                    [string]::IsNullOrWhiteSpace($currentPriority)
                ) {
                    if (-not $priorityOptions.ContainsKey($targetPriority)) {
                        throw "Prioritetsværdien '$targetPriority' findes ikke i Project."
                    }

                    $projectUpdates += [PSCustomObject]@{
                        Name = "Prioritet"
                        FieldId = $priorityFieldId
                        OptionId = $priorityOptions[$targetPriority]
                    }
                }

                if ([string]::IsNullOrWhiteSpace($currentContact) -and -not [string]::IsNullOrWhiteSpace($sourceContact)) {
                    $projectTextUpdates += [PSCustomObject]@{
                        Name = "Kontakt"
                        FieldId = $contactFieldId
                        Value = $sourceContact
                    }
                }

                if ([string]::IsNullOrWhiteSpace($currentMunicipality) -and -not [string]::IsNullOrWhiteSpace($sourceMunicipality)) {
                    $projectTextUpdates += [PSCustomObject]@{
                        Name = "Kommune"
                        FieldId = $municipalityFieldId
                        Value = $sourceMunicipality
                    }
                }

                if ([string]::IsNullOrWhiteSpace($currentJira) -and -not [string]::IsNullOrWhiteSpace($sourceJira)) {
                    $projectTextUpdates += [PSCustomObject]@{
                        Name = "JIRA-Id"
                        FieldId = $jiraFieldId
                        Value = $sourceJira
                    }
                }

                if ($projectUpdates.Count -gt 0 -or $projectTextUpdates.Count -gt 0) {
                    $rateBeforeMutation = Get-RateState
                    if (-not (Test-RateSafe $rateBeforeMutation)) {
                        throw "API-kvoten er under sikkerhedsgrænsen før Project-opdatering. Genkørsel færdiggør issuet."
                    }

                    Set-ProjectFieldsOptimized `
                        -ProjectId $projectId `
                        -ItemId $projectItemId `
                        -SingleSelectUpdates $projectUpdates `
                        -TextUpdates $projectTextUpdates

                    $updatedNames = @($projectUpdates.Name) + @($projectTextUpdates.Name)
                    $actions.Add("Project-felter opdateret: $($updatedNames -join ', ')") | Out-Null
                    Write-Host "  OK: Project-opdatering udført i ét GraphQL-kald ($($updatedNames -join ', '))" -ForegroundColor Green
                }

                $result = "Completed"
                [void]$completedNumbers.Add($n)
            }
        }
        catch {
            $errorText = $_.Exception.Message
            $result = "PartialOrError"
            Write-Host "  STOP/FEJL: $errorText" -ForegroundColor Red

            if ($errorText -match "rate limit|GraphQL|API-kvoten|sikkerhedsgrænsen") {
                $stopRequested = $true
                $stopReason = $errorText
            }
        }

        [void]$log.Add([PSCustomObject]@{
            Issue = $n
            Title = $item.title
            Mode = $Mode
            Result = $result
            Actions = ($actions -join "; ")
            Error = $errorText
            Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        })

        Save-RunState

        if ($stopRequested) { break }

        if ($Mode -eq "Apply" -and $PauseBetweenIssuesMilliseconds -gt 0) {
            Start-Sleep -Milliseconds $PauseBetweenIssuesMilliseconds
        }
    }

    if ($stopRequested) { break }
}

Save-RunState

Write-Host ""
Write-Host "========== Kørsel afsluttet ==========" -ForegroundColor Cyan
Write-Host "Log:          $logPath"
Write-Host "Færdige:      $completedPath"
Write-Host "Ikke færdige: $incompletePath"

$finalRate = Get-RateState
Show-RateState $finalRate

if ($Mode -eq "DryRun") {
    Write-Host "Der er IKKE ændret noget i GitHub." -ForegroundColor Green
}
elseif ($stopRequested) {
    Write-Host "Kørslen stoppede kontrolleret. Genkør samme kommando efter reset." -ForegroundColor Yellow
    Write-Host "Årsag: $stopReason"
}
else {
    Write-Host "Alle valgte issues er behandlet." -ForegroundColor Green
}
