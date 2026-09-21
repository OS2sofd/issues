param(
    [Parameter(Mandatory = $true)]
    [int]$IssueNumber,

    [ValidateSet("DryRun", "Apply")]
    [string]$Mode = "DryRun",

    [string]$Owner = "OS2sofd",
    [string]$Repo = "issues",
    [int]$ProjectNumber = 1,
    [string]$EstimateFieldName = "Estimat"
)

$ErrorActionPreference = "Stop"

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

function Convert-ToEstimateValue {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RawAmount
    )

    $clean = $RawAmount.Trim()
    $clean = $clean -replace '(?i)\b(DKK|DKR|KRONER|KR)\b', ''
    $clean = $clean -replace '\s+', ''
    $clean = $clean -replace ',-$', ''
    $clean = $clean -replace ',-', ''
    $clean = $clean.Trim()

    $digits = $clean -replace '[\.,]', ''

    if ($digits -notmatch '^\d+$') {
        return $null
    }

    $value = [int64]$digits

    if ($value -le 0) {
        return $null
    }

    $formatted = "{0:N0}" -f $value
    $formatted = $formatted -replace ',', '.'

    return "${formatted}kr"
}

function Normalize-MarkdownLine {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Line
    )

    $normalized = $Line.Trim()

    # Fjern almindelig Markdown-formatering omkring overskrifter/feltnavne.
    # Eksempler:
    #   Pris
    #   **Pris**
    #   ### Pris
    #   **Pris:**
    #   **Pris: 9.500 DKK**
    $normalized = $normalized -replace '^\s*#{1,6}\s*', ''
    $normalized = $normalized -replace '^\s*[*_]{1,3}\s*', ''
    $normalized = $normalized -replace '\s*[*_]{1,3}\s*$', ''

    return $normalized.Trim()
}

function Find-EstimateInComment {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Body
    )

    $lines = $Body -split "`r?`n"

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = Normalize-MarkdownLine -Line $lines[$i]

        # Match tydelige pris-/estimatmarkører - også når de er Markdown-formateret.
        if ($line -match '(?i)^(pris|estimat|estimeret pris)\s*:?\s*(.*)$') {
            $tail = $Matches[2].Trim()

            $candidateTexts = @()

            if (-not [string]::IsNullOrWhiteSpace($tail)) {
                $candidateTexts += $tail
            }

            if (($i + 1) -lt $lines.Count) {
                $next = Normalize-MarkdownLine -Line $lines[$i + 1]
                if (-not [string]::IsNullOrWhiteSpace($next)) {
                    $candidateTexts += $next
                }
            }

            $found = @()

            foreach ($candidate in $candidateTexts) {
                # Accepter bl.a.:
                # 16.500 DKK
                # 16 500 kr
                # 16,500
                # 16500
                # 16000,-
                $matches = [regex]::Matches(
                    $candidate,
                    '(?i)(?<!\d)(\d{1,3}(?:[.\s,]\d{3})+|\d{4,9})(?:\s*(?:DKK|DKR|KRONER|KR))?(?:,-)?(?!\d)'
                )

                foreach ($m in $matches) {
                    $normalized = Convert-ToEstimateValue -RawAmount $m.Value
                    if ($null -ne $normalized) {
                        $found += [pscustomobject]@{
                            Raw        = $m.Value
                            Normalized = $normalized
                        }
                    }
                }
            }

            $unique = @($found | Sort-Object Normalized -Unique)

            if ($unique.Count -eq 1) {
                return [pscustomobject]@{
                    Found      = $true
                    Raw        = $unique[0].Raw
                    Normalized = $unique[0].Normalized
                }
            }

            if ($unique.Count -gt 1) {
                return [pscustomobject]@{
                    Found      = $false
                    Ambiguous  = $true
                    Message    = "Flere forskellige beløb fundet ved pris/estimat-markøren."
                }
            }
        }
    }

    return [pscustomobject]@{
        Found     = $false
        Ambiguous = $false
        Message   = "Ingen entydig pris/estimat-markør med beløb fundet."
    }
}

Write-Host "Henter kommentarer til issue #$IssueNumber..." -ForegroundColor Cyan

$comments = Invoke-GhJson -Arguments @(
    "api",
    "--paginate",
    "repos/$Owner/$Repo/issues/$IssueNumber/comments"
)

if ($null -eq $comments) {
    throw "Ingen kommentarer fundet på issue #$IssueNumber."
}

$priceHit = $null

foreach ($comment in @($comments | Sort-Object created_at -Descending)) {
    $result = Find-EstimateInComment -Body $comment.body

    if ($result.Found) {
        $priceHit = [pscustomobject]@{
            CommentId  = $comment.id
            Author     = $comment.user.login
            CreatedAt  = $comment.created_at
            Raw        = $result.Raw
            Normalized = $result.Normalized
        }
        break
    }

    if ($result.Ambiguous) {
        Write-Warning "Kommentar $($comment.id) af $($comment.user.login) indeholder en tvetydig pris. Springes over."
    }
}

if ($null -eq $priceHit) {
    Write-Warning "Der blev ikke fundet en entydig estimeret pris. Project-feltet ændres ikke."
    exit 2
}

Write-Host ""
Write-Host "Fundet pris:" -ForegroundColor Green
Write-Host "  Kommentar: $($priceHit.CommentId)"
Write-Host "  Forfatter: $($priceHit.Author)"
Write-Host "  Oprindelig værdi: $($priceHit.Raw)"
Write-Host "  Normaliseret: $($priceHit.Normalized)"
Write-Host ""

Write-Host "Finder Project, felt og item..." -ForegroundColor Cyan

$project = Invoke-GhJson -Arguments @(
    "project", "view",
    "$ProjectNumber",
    "--owner", "$Owner",
    "--format", "json"
)

$projectId = $project.id
if ([string]::IsNullOrWhiteSpace($projectId)) {
    throw "Kunne ikke finde Project ID."
}

$fields = Invoke-GhJson -Arguments @(
    "project", "field-list",
    "$ProjectNumber",
    "--owner", "$Owner",
    "--format", "json"
)

$field = @($fields.fields | Where-Object { $_.name -eq $EstimateFieldName }) | Select-Object -First 1
if ($null -eq $field) {
    throw "Kunne ikke finde Project-feltet '$EstimateFieldName'."
}

$items = Invoke-GhJson -Arguments @(
    "project", "item-list",
    "$ProjectNumber",
    "--owner", "$Owner",
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

Write-Host "Project-felt: $EstimateFieldName"
Write-Host "Ny værdi:     $($priceHit.Normalized)"
Write-Host ""

if ($Mode -eq "DryRun") {
    Write-Host "DRY RUN: Ingen ændringer er skrevet." -ForegroundColor Yellow
    Write-Host "Kør igen med -Mode Apply for at skrive værdien."
    exit 0
}

Write-Host "Skriver estimat til Project..." -ForegroundColor Cyan

& gh project item-edit `
    --id $item.id `
    --project-id $projectId `
    --field-id $field.id `
    --text $priceHit.Normalized

if ($LASTEXITCODE -ne 0) {
    throw "Kunne ikke opdatere Project-feltet '$EstimateFieldName'."
}

Write-Host ""
Write-Host "OK: Estimat på issue #$IssueNumber er sat til $($priceHit.Normalized)." -ForegroundColor Green
