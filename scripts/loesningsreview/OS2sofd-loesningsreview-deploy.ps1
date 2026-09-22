param(
    [Parameter(Mandatory = $true)]
    [string]$ResultPath,

    [ValidateSet("DryRun", "Apply")]
    [string]$Mode = "DryRun",

    [string]$Owner = "OS2sofd",
    [string]$Repo = "issues",

    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,
    [string]$EstimateFieldName = "Estimat",

    [switch]$SkipEstimate
)

$ErrorActionPreference = "Stop"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom

if ($env:OS -eq "Windows_NT") {
    & chcp 65001 *> $null
}

function Invoke-GhJson {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $output = & gh @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "gh fejlede: $($output -join "`n")"
    }

    $text = $output -join "`n"
    if ([string]::IsNullOrWhiteSpace($text)) {
        return $null
    }

    return $text | ConvertFrom-Json
}


function Set-ProjectEstimate {
    param(
        [Parameter(Mandatory = $true)]
        [int]$IssueNumber,

        [Parameter(Mandatory = $true)]
        [string]$Estimate,

        [Parameter(Mandatory = $true)]
        [ValidateSet("DryRun", "Apply")]
        [string]$Mode
    )

    if ([string]::IsNullOrWhiteSpace($Estimate)) {
        Write-Host "Estimat: ingen værdi i review-resultatet. Project-feltet ændres ikke." -ForegroundColor DarkGray
        return
    }

    $project = Invoke-GhJson -Arguments @(
        "project", "view",
        "$ProjectNumber",
        "--owner", "$ProjectOwner",
        "--format", "json"
    )

    $projectId = [string]$project.id
    if ([string]::IsNullOrWhiteSpace($projectId)) {
        throw "Kunne ikke finde Project ID for $ProjectOwner / #$ProjectNumber."
    }

    $fields = Invoke-GhJson -Arguments @(
        "project", "field-list",
        "$ProjectNumber",
        "--owner", "$ProjectOwner",
        "--format", "json"
    )

    $field = @(
        $fields.fields | Where-Object { $_.name -eq $EstimateFieldName }
    ) | Select-Object -First 1

    if ($null -eq $field) {
        throw "Kunne ikke finde Project-feltet '$EstimateFieldName'."
    }

    $items = Invoke-GhJson -Arguments @(
        "project", "item-list",
        "$ProjectNumber",
        "--owner", "$ProjectOwner",
        "--format", "json",
        "--limit", "1000"
    )

    $item = @(
        $items.items | Where-Object {
            $_.content.repository -eq "$Owner/$Repo" -and
            $_.content.number -eq $IssueNumber
        }
    ) | Select-Object -First 1

    if ($null -eq $item) {
        throw "Issue #$IssueNumber blev ikke fundet i Project #$ProjectNumber."
    }

    $currentEstimate = ""
    $estimateProp = $item.PSObject.Properties |
        Where-Object { $_.Name -ieq $EstimateFieldName } |
        Select-Object -First 1

    if ($null -ne $estimateProp -and $null -ne $estimateProp.Value) {
        $currentEstimate = [string]$estimateProp.Value
    }

    if ($currentEstimate -eq $Estimate) {
        Write-Host "Estimat: Project-feltet er allerede '$Estimate'." -ForegroundColor Green
        return
    }

    if ([string]::IsNullOrWhiteSpace($currentEstimate)) {
        Write-Host "Estimat: sætter '$EstimateFieldName' til '$Estimate'." -ForegroundColor Yellow
    }
    else {
        Write-Host "Estimat: ændrer '$EstimateFieldName' fra '$currentEstimate' til '$Estimate'." -ForegroundColor Yellow
    }

    if ($Mode -eq "DryRun") {
        Write-Host "DRY RUN: Estimat ændres ikke." -ForegroundColor Yellow
        return
    }

    & gh project item-edit `
        --id $item.id `
        --project-id $projectId `
        --field-id $field.id `
        --text $Estimate

    if ($LASTEXITCODE -ne 0) {
        throw "Kunne ikke opdatere Project-feltet '$EstimateFieldName'."
    }

    Write-Host "OK: Estimat på issue #$IssueNumber er sat til $Estimate." -ForegroundColor Green
}

function Add-Line {
    param(
        [System.Collections.Generic.List[string]]$Lines,
        [string]$Text = ""
    )
    [void]$Lines.Add($Text)
}

if (-not (Test-Path -LiteralPath $ResultPath)) {
    throw "Resultatfilen findes ikke: $ResultPath"
}

$result = Get-Content -LiteralPath $ResultPath -Raw -Encoding UTF8 | ConvertFrom-Json

if ($null -eq $result.issue_number) {
    throw "Resultatfilen mangler 'issue_number'."
}

$issueNumber = [int]$result.issue_number
$solutionAuthor = [string]$result.solution_author
$issueAuthor = [string]$result.issue_author

$contactName = ""
$contactGithub = ""
$mentionContact = $false

if ($null -ne $result.contact_name) {
    $contactName = [string]$result.contact_name
}
elseif ($null -ne $result.contact -and $null -ne $result.contact.name) {
    $contactName = [string]$result.contact.name
}

if ($null -ne $result.contact_github) {
    $contactGithub = [string]$result.contact_github
}
elseif ($null -ne $result.contact -and $null -ne $result.contact.github) {
    $contactGithub = [string]$result.contact.github
}

if ($null -ne $result.mention_contact) {
    $mentionContact = [bool]$result.mention_contact
}
elseif ($null -ne $result.mention_contact_github) {
    # Bagudkompatibilitet med enkelte tidlige review-resultater.
    $mentionContact = [bool]$result.mention_contact_github
}

$reviewNumber = 1
if ($null -ne $result.review_number -and [int]$result.review_number -gt 0) {
    $reviewNumber = [int]$result.review_number
}

$reviewedThroughCommentId = 0
if ($null -ne $result.reviewed_through_comment_id) {
    $reviewedThroughCommentId = [long]$result.reviewed_through_comment_id
}

if ($reviewedThroughCommentId -le 0) {
    throw "Resultatfilen mangler et gyldigt 'reviewed_through_comment_id'."
}

$marker = "<!-- os2sofd-loesningsreview-v1 issue:$issueNumber review:$reviewNumber reviewed-through-comment:$reviewedThroughCommentId -->"

$lines = New-Object 'System.Collections.Generic.List[string]'

if ($reviewNumber -gt 1) {
    Add-Line $lines "## PO-review af løsningsbeskrivelse – opfølgning"
}
else {
    Add-Line $lines "## PO-review af løsningsbeskrivelse"
}
Add-Line $lines ""

# Ingen @mentions i reviewets indledning.
# Løsningsbeskriver og eventuel kontaktperson notificeres kun,
# hvis reviewet indeholder konkrete afklarende spørgsmål.

if (-not [string]::IsNullOrWhiteSpace([string]$result.change_character)) {
    Add-Line $lines ("**Ændringens karakter:** " + [string]$result.change_character)
    Add-Line $lines ""
}

Add-Line $lines "| Kriterium | Relevans | Vurdering |"
Add-Line $lines "| --- | --- | --- |"

foreach ($criterion in @($result.criteria)) {
    $name = [string]$criterion.name
    $relevance = [string]$criterion.relevance
    $rating = [string]$criterion.rating
    Add-Line $lines "| $name | $relevance | $rating |"
}

$attention = @($result.attention_points | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })

if ($attention.Count -gt 0) {
    Add-Line $lines ""
    Add-Line $lines "### Opmærksomhed"
    Add-Line $lines ""

    foreach ($point in $attention) {
        Add-Line $lines ("- " + [string]$point)
    }
}

$questions = @($result.supplier_questions | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })

if ($questions.Count -gt 0) {
    Add-Line $lines ""
    Add-Line $lines "### Afklaring"
    Add-Line $lines ""

    $questionMentions = New-Object 'System.Collections.Generic.List[string]'

    if (-not [string]::IsNullOrWhiteSpace($solutionAuthor)) {
        [void]$questionMentions.Add("@$solutionAuthor")
    }

    if (
        $mentionContact -and
        -not [string]::IsNullOrWhiteSpace($contactGithub) -and
        $contactGithub -ne $solutionAuthor
    ) {
        [void]$questionMentions.Add("@$contactGithub")
    }
    elseif (
        $null -eq $result.mention_contact -and
        $null -eq $result.mention_contact_github -and
        $result.mention_issue_author -eq $true -and
        -not [string]::IsNullOrWhiteSpace($issueAuthor) -and
        $issueAuthor -ne $solutionAuthor
    ) {
        # Kun bagudkompatibilitet. Nye reviews skal bruge kontaktpersonen.
        [void]$questionMentions.Add("@$issueAuthor")
    }

    if (
        $mentionContact -and
        [string]::IsNullOrWhiteSpace($contactGithub) -and
        -not [string]::IsNullOrWhiteSpace($contactName)
    ) {
        Add-Line $lines ("**Kontaktperson:** " + $contactName + " – GitHub-brugernavn kunne ikke identificeres automatisk.")
        Add-Line $lines ""
    }

    if ($questionMentions.Count -gt 1) {
        Add-Line $lines (($questionMentions -join " ") + " Kan I kort supplere:")
    }
    elseif ($questionMentions.Count -eq 1) {
        Add-Line $lines (($questionMentions -join " ") + " Kan du kort supplere:")
    }
    else {
        Add-Line $lines "Kan du kort supplere:"
    }

    foreach ($question in $questions) {
        Add-Line $lines ("- " + [string]$question)
    }
}

if (-not [string]::IsNullOrWhiteSpace([string]$result.estimate)) {
    Add-Line $lines ""
    Add-Line $lines "### Estimat"
    Add-Line $lines ""
    Add-Line $lines ([string]$result.estimate)
}

Add-Line $lines ""
Add-Line $lines "### Samlet PO-review"
Add-Line $lines ""

$overallRating = [string]$result.overall_rating
$overall = [string]$result.overall

if (-not [string]::IsNullOrWhiteSpace($overallRating)) {
    Add-Line $lines "$overallRating **$overall**"
}
else {
    Add-Line $lines "**$overall**"
}

Add-Line $lines ""
Add-Line $lines $marker

$body = $lines -join "`n"

Write-Host ""
Write-Host "Reviewkommentar for issue #$issueNumber" -ForegroundColor Cyan
Write-Host "------------------------------------------------------------"
Write-Host $body
Write-Host "------------------------------------------------------------"
Write-Host ""

# Estimat håndteres normalt som en del af samme DryRun/Apply som reviewkommentaren.
# Ved batch-kørsel håndterer batch-scriptet estimater samlet for at spare GraphQL-kald.
if (-not $SkipEstimate) {
    Set-ProjectEstimate `
        -IssueNumber $issueNumber `
        -Estimate ([string]$result.estimate) `
        -Mode $Mode

    Write-Host ""
}

# Beskyt mod at samme review-resultat postes flere gange.
$comments = Invoke-GhJson -Arguments @(
    "api",
    "--paginate",
    "repos/$Owner/$Repo/issues/$issueNumber/comments"
)

$duplicate = @(
    $comments | Where-Object {
        [string]$_.body -like "*$marker*"
    }
) | Select-Object -First 1

if ($null -ne $duplicate) {
    Write-Host "Ingen handling: Dette review er allerede postet som kommentar id $($duplicate.id)." -ForegroundColor Green
    exit 0
}

Write-Host "Handling: Opret ny reviewkommentar (review $reviewNumber)." -ForegroundColor Yellow

if ($Mode -eq "DryRun") {
    Write-Host ""
    Write-Host "DRY RUN: Ingen ændringer er skrevet til GitHub." -ForegroundColor Yellow
    exit 0
}

$tempFile = Join-Path ([System.IO.Path]::GetTempPath()) ("os2sofd-review-" + [guid]::NewGuid().ToString() + ".md")
[System.IO.File]::WriteAllText($tempFile, $body, $Utf8NoBom)

try {
    & gh api `
        "repos/$Owner/$Repo/issues/$issueNumber/comments" `
        --method POST `
        --field "body=@$tempFile"

    if ($LASTEXITCODE -ne 0) {
        throw "Kunne ikke oprette reviewkommentaren."
    }

    Write-Host ""
    Write-Host "OK: Review $reviewNumber oprettet som ny kommentar på issue #$issueNumber." -ForegroundColor Green
}
finally {
    if (Test-Path -LiteralPath $tempFile) {
        Remove-Item -LiteralPath $tempFile -Force
    }
}
