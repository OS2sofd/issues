param(
    [Parameter(Mandatory = $true)]
    [int]$IssueNumber,

    [string]$Owner = "OS2sofd",
    [string]$Repo = "issues",

    [long]$SolutionCommentId = 0,

    [string]$OutputPath = ""
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

function Normalize-MarkdownLine {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Line
    )

    $normalized = $Line.Trim()
    $normalized = $normalized -replace '^\s*#{1,6}\s*', ''
    $normalized = $normalized -replace '^\s*[*_]{1,3}\s*', ''
    $normalized = $normalized -replace '\s*[*_]{1,3}\s*$', ''
    return $normalized.Trim()
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

function Find-EstimateInComment {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Body
    )

    $lines = $Body -split "`r?`n"

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = Normalize-MarkdownLine -Line $lines[$i]

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
                $matches = [regex]::Matches(
                    $candidate,
                    '(?i)(?<!\d)(\d{1,3}(?:[.\s,]\d{3})+|\d{4,9})(?:\s*(?:DKK|DKR|KRONER|KR))?(?:,-)?(?!\d)'
                )

                foreach ($m in $matches) {
                    $normalized = Convert-ToEstimateValue -RawAmount $m.Value
                    if ($null -ne $normalized) {
                        $found += [pscustomobject]@{
                            raw        = $m.Value
                            normalized = $normalized
                        }
                    }
                }
            }

            $unique = @($found | Sort-Object normalized -Unique)

            if ($unique.Count -eq 1) {
                return [pscustomobject]@{
                    found      = $true
                    ambiguous  = $false
                    raw        = $unique[0].raw
                    normalized = $unique[0].normalized
                }
            }

            if ($unique.Count -gt 1) {
                return [pscustomobject]@{
                    found      = $false
                    ambiguous  = $true
                    raw        = $null
                    normalized = $null
                }
            }
        }
    }

    return [pscustomobject]@{
        found      = $false
        ambiguous  = $false
        raw        = $null
        normalized = $null
    }
}

function Get-SolutionCommentScore {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Comment
    )

    $body = [string]$Comment.body
    $score = 0

    if ($body -match '(?i)løsningsbeskrivelse') { $score += 100 }
    if ($body -match '(?i)(^|\n)\s*(#{1,6}\s*)?[*_]{0,3}(løsning|løsningsforslag|foreslået løsning)[*_]{0,3}\s*:?\s*($|\n)') { $score += 60 }
    if ($body -match '(?i)(^|\n)\s*(#{1,6}\s*)?[*_]{0,3}(pris|estimat|estimeret pris)[*_]{0,3}\s*:?\s*') { $score += 50 }

    $estimate = Find-EstimateInComment -Body $body
    if ($estimate.found) { $score += 50 }

    if ($body.Length -ge 300) { $score += 10 }

    return $score
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $PSScriptRoot ("OS2sofd-loesningsreview-input-{0}.json" -f $IssueNumber)
}

Write-Host "Henter issue #$IssueNumber..." -ForegroundColor Cyan

$issue = Invoke-GhJson -Arguments @(
    "api",
    "repos/$Owner/$Repo/issues/$IssueNumber"
)

$commentsRaw = Invoke-GhJson -Arguments @(
    "api",
    "--paginate",
    "repos/$Owner/$Repo/issues/$IssueNumber/comments"
)

$comments = @($commentsRaw)

if ($comments.Count -eq 0) {
    throw "Issue #$IssueNumber har ingen kommentarer. Der kan ikke identificeres en løsningsbeskrivelse."
}

$solutionComment = $null
$selectionMethod = $null

if ($SolutionCommentId -gt 0) {
    $solutionComment = @($comments | Where-Object { [long]$_.id -eq $SolutionCommentId }) | Select-Object -First 1

    if ($null -eq $solutionComment) {
        throw "Kommentar-id $SolutionCommentId blev ikke fundet på issue #$IssueNumber."
    }

    $selectionMethod = "manual_comment_id"
}
else {
    $candidates = foreach ($comment in $comments) {
        $score = Get-SolutionCommentScore -Comment $comment
        if ($score -gt 0) {
            [pscustomobject]@{
                comment = $comment
                score   = $score
            }
        }
    }

    $best = @(
        $candidates |
        Sort-Object `
            @{ Expression = "score"; Descending = $true },
            @{ Expression = { [datetime]$_.comment.created_at }; Descending = $true }
    ) | Select-Object -First 1

    if ($null -eq $best) {
        throw @"
Kunne ikke identificere en sandsynlig løsningsbeskrivelse automatisk.
Kør scriptet igen med -SolutionCommentId <id> for at vælge kommentaren manuelt.
"@
    }

    $solutionComment = $best.comment
    $selectionMethod = "automatic_score_$($best.score)"
}

$estimate = Find-EstimateInComment -Body ([string]$solutionComment.body)

$contextComments = @(
    $comments | ForEach-Object {
        [ordered]@{
            id         = [long]$_.id
            author     = [string]$_.user.login
            created_at = [string]$_.created_at
            updated_at = [string]$_.updated_at
            body       = [string]$_.body
        }
    }
)

$result = [ordered]@{
    schema_version = "1.0"
    generated_at   = (Get-Date).ToString("o")
    repository     = "$Owner/$Repo"

    issue = [ordered]@{
        number     = [int]$issue.number
        title      = [string]$issue.title
        url        = [string]$issue.html_url
        author     = [string]$issue.user.login
        created_at = [string]$issue.created_at
        updated_at = [string]$issue.updated_at
        body       = [string]$issue.body
        labels     = @($issue.labels | ForEach-Object { [string]$_.name })
    }

    solution_comment = [ordered]@{
        id               = [long]$solutionComment.id
        author           = [string]$solutionComment.user.login
        created_at       = [string]$solutionComment.created_at
        updated_at       = [string]$solutionComment.updated_at
        selection_method = $selectionMethod
        body             = [string]$solutionComment.body
    }

    estimate = [ordered]@{
        found      = [bool]$estimate.found
        ambiguous  = [bool]$estimate.ambiguous
        raw        = $estimate.raw
        normalized = $estimate.normalized
    }

    context_comments = $contextComments
}

$json = $result | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText(
    $OutputPath,
    $json,
    (New-Object System.Text.UTF8Encoding($false))
)

Write-Host ""
Write-Host "Løsningsbeskrivelse fundet:" -ForegroundColor Green
Write-Host "  Kommentar: $($solutionComment.id)"
Write-Host "  Forfatter: @$($solutionComment.user.login)"
Write-Host "  Valg:      $selectionMethod"

if ($estimate.found) {
    Write-Host "  Estimat:   $($estimate.raw) -> $($estimate.normalized)"
}
elseif ($estimate.ambiguous) {
    Write-Warning "Pris/estimat er tvetydigt i den valgte kommentar."
}
else {
    Write-Warning "Ingen entydig pris blev fundet i den valgte kommentar."
}

Write-Host ""
Write-Host "Review-input gemt:" -ForegroundColor Cyan
Write-Host "  $OutputPath"
Write-Host ""
Write-Host "Upload JSON-filen til ChatGPT for PO-review efter po-review-loesningsbeskrivelser-v1.md."
