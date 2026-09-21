param(
    [Parameter(Mandatory = $true)]
    [int]$IssueNumber,

    [string]$Owner = "OS2sofd",
    [string]$Repo = "issues",

    [long]$SolutionCommentId = 0,

    [string]$OutputPath = ""
)

$ErrorActionPreference = "Stop"

# Sørg for korrekt UTF-8 ved output fra native kommandoer som GitHub CLI (gh).
# Det er især vigtigt for danske tegn i issue-tekst og kommentarer.
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
        [string[]]$Arguments,

        [int]$MaxAttempts = 3
    )

    for ($attempt = 1; $attempt -le $MaxAttempts; $attempt++) {
        $oldPreference = $ErrorActionPreference

        try {
            # Windows PowerShell kan ellers gøre stderr fra gh til en
            # terminating NativeCommandError, før vi selv kan håndtere fejlen.
            $ErrorActionPreference = "Continue"
            $output = & gh @Arguments 2>&1
            $exitCode = $LASTEXITCODE
        }
        finally {
            $ErrorActionPreference = $oldPreference
        }

        $text = ($output -join "`n").Trim()

        if ($exitCode -eq 0) {
            if ([string]::IsNullOrWhiteSpace($text)) {
                return $null
            }

            return $text | ConvertFrom-Json
        }

        $isTransient = (
            $text -match '(?i)502|Bad Gateway|' +
                         '503|Service Unavailable|' +
                         '504|Gateway Timeout|' +
                         'temporarily unavailable'
        )

        if ($isTransient -and $attempt -lt $MaxAttempts) {
            $waitSeconds = 3 * $attempt
            Write-Warning "Midlertidig GitHub-fejl ved gh $($Arguments -join ' '). Forsøg $attempt/$MaxAttempts. Prøver igen om $waitSeconds sek."
            Start-Sleep -Seconds $waitSeconds
            continue
        }

        throw "gh fejlede efter $attempt forsøg: $text"
    }
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


function Get-IssueFormValue {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Body,

        [Parameter(Mandatory = $true)]
        [string]$Heading
    )

    if ([string]::IsNullOrWhiteSpace($Body)) {
        return ""
    }

    $escapedHeading = [regex]::Escape($Heading)
    $pattern = "(?ms)^###\s*$escapedHeading\s*\r?\n+(?<value>.*?)(?=^###\s|\z)"
    $match = [regex]::Match($Body, $pattern)

    if (-not $match.Success) {
        return ""
    }

    $value = $match.Groups["value"].Value.Trim()

    if ($value -match '^(?i)_?No response_?$') {
        return ""
    }

    return $value
}

function Normalize-PersonName {
    param(
        [AllowEmptyString()]
        [string]$Name
    )

    if ([string]::IsNullOrWhiteSpace($Name)) {
        return ""
    }

    $value = $Name.Trim().ToLowerInvariant()
    $value = $value -replace '\s+', ' '
    return $value
}

function Test-GitHubUserMatchesContact {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Login,

        [Parameter(Mandatory = $true)]
        [string]$ContactName
    )

    if ([string]::IsNullOrWhiteSpace($Login) -or [string]::IsNullOrWhiteSpace($ContactName)) {
        return $false
    }

    try {
        $profile = Invoke-GhJson -Arguments @(
            "api",
            "users/$Login"
        )

        $profileName = [string]$profile.name
        if ([string]::IsNullOrWhiteSpace($profileName)) {
            return $false
        }

        return (
            (Normalize-PersonName -Name $profileName) -eq
            (Normalize-PersonName -Name $ContactName)
        )
    }
    catch {
        return $false
    }
}

function Resolve-ContactGitHub {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ContactName,

        [Parameter(Mandatory = $true)]
        [string]$IssueAuthor,

        [Parameter(Mandatory = $true)]
        [string]$Owner,

        [Parameter(Mandatory = $true)]
        [string]$Repo
    )

    if ([string]::IsNullOrWhiteSpace($ContactName)) {
        return [pscustomobject]@{
            login  = ""
            method = "no_contact_name"
        }
    }

    # Første og billigste kontrol: svarer issue-forfatterens GitHub-profil
    # faktisk til kontaktpersonen i formularen?
    if (
        -not [string]::IsNullOrWhiteSpace($IssueAuthor) -and
        (Test-GitHubUserMatchesContact -Login $IssueAuthor -ContactName $ContactName)
    ) {
        return [pscustomobject]@{
            login  = $IssueAuthor
            method = "issue_author_profile_match"
        }
    }

    # Hvis ikke: se efter andre issues i samme repo med samme kontaktperson.
    # Et GitHub-login accepteres kun, hvis profilens navn også matcher
    # kontaktpersonen. Dermed undgår vi at antage, at issue-forfatter = kontakt.
    try {
        $repoIssues = Invoke-GhJson -Arguments @(
            "issue", "list",
            "--repo", "$Owner/$Repo",
            "--state", "all",
            "--limit", "1000",
            "--json", "number,author,body"
        )

        $candidateLogins = @()

        foreach ($repoIssue in @($repoIssues)) {
            $body = [string]$repoIssue.body
            $name = Get-IssueFormValue -Body $body -Heading "Navn"

            if (
                -not [string]::IsNullOrWhiteSpace($name) -and
                (Normalize-PersonName -Name $name) -eq (Normalize-PersonName -Name $ContactName)
            ) {
                $login = [string]$repoIssue.author.login
                if (-not [string]::IsNullOrWhiteSpace($login)) {
                    $candidateLogins += $login
                }
            }
        }

        $candidateLogins = @($candidateLogins | Sort-Object -Unique)

        $verified = @(
            $candidateLogins |
            Where-Object {
                Test-GitHubUserMatchesContact -Login $_ -ContactName $ContactName
            }
        )

        if ($verified.Count -eq 1) {
            return [pscustomobject]@{
                login  = [string]$verified[0]
                method = "verified_from_other_issue"
            }
        }
    }
    catch {
        # Manglende opslag må ikke stoppe review-input.
    }

    return [pscustomobject]@{
        login  = ""
        method = "unresolved"
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

$contactName = Get-IssueFormValue -Body ([string]$issue.body) -Heading "Navn"
$contactEmail = Get-IssueFormValue -Body ([string]$issue.body) -Heading "Mail"
$contactMunicipality = Get-IssueFormValue -Body ([string]$issue.body) -Heading "Kommune"

$contactResolution = Resolve-ContactGitHub `
    -ContactName $contactName `
    -IssueAuthor ([string]$issue.user.login) `
    -Owner $Owner `
    -Repo $Repo

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
        # Tidligere PO-reviewkommentarer må aldrig kunne vælges som
        # leverandørens løsningsbeskrivelse ved en senere kørsel.
        if ([string]$comment.body -match 'os2sofd-loesningsreview-v1') {
            continue
        }

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


# Find tidligere PO-reviews og identificer nye kommentarer siden seneste review.
$reviewMarkerPattern = '<!--\s*os2sofd-loesningsreview-v1\s+issue:(\d+)\s+review:(\d+)\s+reviewed-through-comment:(\d+)\s*-->'

$previousReviews = @()

foreach ($comment in $comments) {
    $match = [regex]::Match([string]$comment.body, $reviewMarkerPattern)
    if ($match.Success) {
        $previousReviews += [pscustomobject]@{
            comment_id                = [long]$comment.id
            review_number             = [int]$match.Groups[2].Value
            reviewed_through_comment_id = [long]$match.Groups[3].Value
            author                    = [string]$comment.user.login
            created_at                = [string]$comment.created_at
        }
    }
}

$latestPreviousReview = @(
    $previousReviews | Sort-Object review_number -Descending
) | Select-Object -First 1

$nextReviewNumber = 1
$lastReviewedThroughCommentId = 0

if ($null -ne $latestPreviousReview) {
    $nextReviewNumber = [int]$latestPreviousReview.review_number + 1
    $lastReviewedThroughCommentId = [long]$latestPreviousReview.reviewed_through_comment_id
}

$newCommentsSinceLastReview = @(
    $comments |
    Where-Object {
        $body = [string]$_.body

        [long]$_.id -gt $lastReviewedThroughCommentId -and
        $body -notmatch 'os2sofd-loesningsreview-v1' -and
        $body -notmatch 'os2sofd-klar-til-bestilling' -and
        $body -notmatch 'os2sofd-screening-v3'
    } |
    Sort-Object created_at
)

$currentReviewedThroughCommentId = 0
if ($comments.Count -gt 0) {
    $currentReviewedThroughCommentId = [long](
        $comments |
        Sort-Object { [long]$_.id } -Descending |
        Select-Object -First 1
    ).id
}

# Hvis issuet allerede er reviewet, og der ikke er kommet nye kommentarer,
# er der intet nyt reviewgrundlag. Stop uden at oprette en ny inputfil.
if ($null -ne $latestPreviousReview -and @($newCommentsSinceLastReview).Count -eq 0) {
    Write-Host ""
    Write-Host "Tidligere PO-review fundet: review $($latestPreviousReview.review_number)." -ForegroundColor Green
    Write-Host "Senest reviewet t.o.m. kommentar: $lastReviewedThroughCommentId"
    Write-Host "Nye kommentarer siden seneste review: 0"
    Write-Host ""
    Write-Host "Ingen handling: Issue #$IssueNumber skal ikke reviewes igen." -ForegroundColor Green
    exit 0
}

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

    contact = [ordered]@{
        name              = $contactName
        email             = $contactEmail
        municipality      = $contactMunicipality
        github            = [string]$contactResolution.login
        resolution_method = [string]$contactResolution.method
    }

    solution_comment = [ordered]@{
        id               = [long]$solutionComment.id
        author           = [string]$solutionComment.user.login
        created_at       = [string]$solutionComment.created_at
        updated_at       = [string]$solutionComment.updated_at
        selection_method = $selectionMethod
        body             = [string]$solutionComment.body
    }

    review_state = [ordered]@{
        previous_review_count             = @($previousReviews).Count
        next_review_number                = $nextReviewNumber
        last_reviewed_through_comment_id  = $lastReviewedThroughCommentId
        reviewed_through_comment_id       = $currentReviewedThroughCommentId
        new_comment_count_since_last_review = @($newCommentsSinceLastReview).Count
        has_new_comments_since_last_review  = (@($newCommentsSinceLastReview).Count -gt 0)
    }

    previous_reviews = @(
        $previousReviews | ForEach-Object {
            [ordered]@{
                comment_id                  = $_.comment_id
                review_number               = $_.review_number
                reviewed_through_comment_id = $_.reviewed_through_comment_id
                author                      = $_.author
                created_at                  = $_.created_at
            }
        }
    )

    new_comments_since_last_review = @(
        $newCommentsSinceLastReview | ForEach-Object {
            [ordered]@{
                id         = [long]$_.id
                author     = [string]$_.user.login
                created_at = [string]$_.created_at
                updated_at = [string]$_.updated_at
                body       = [string]$_.body
            }
        }
    )

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
Write-Host ""
Write-Host "Kontaktperson:" -ForegroundColor Cyan
Write-Host "  Navn:      $contactName"
if (-not [string]::IsNullOrWhiteSpace($contactEmail)) {
    Write-Host "  Mail:      $contactEmail"
}
if (-not [string]::IsNullOrWhiteSpace($contactMunicipality)) {
    Write-Host "  Kommune:   $contactMunicipality"
}
if (-not [string]::IsNullOrWhiteSpace([string]$contactResolution.login)) {
    Write-Host "  GitHub:    @$($contactResolution.login)"
    Write-Host "  Opløst via: $($contactResolution.method)"
}
else {
    Write-Host "  GitHub:    ikke identificeret automatisk"
}

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
if ($null -eq $latestPreviousReview) {
    Write-Host "  Tidligere PO-review: Ingen"
    Write-Host "  Næste reviewnr.:     1"
}
else {
    Write-Host "  Tidligere PO-reviews: $(@($previousReviews).Count)"
    Write-Host "  Senest reviewet t.o.m. kommentar: $lastReviewedThroughCommentId"
    Write-Host "  Nye kommentarer siden seneste review: $(@($newCommentsSinceLastReview).Count)"
    Write-Host "  Næste reviewnr.: $nextReviewNumber"
}
Write-Host ""

Write-Host "Review-input gemt:" -ForegroundColor Cyan
Write-Host "  $OutputPath"
Write-Host ""
Write-Host "Upload JSON-filen til ChatGPT for PO-review efter po-review-loesningsbeskrivelser-v1.md."
