param(
    [string]$Owner = "OS2sofd",
    [string]$Repo = "issues",
    [int]$ProjectNumber = 1,
    [string]$TargetStatus = "Klar til prioritering",
    [string]$SingleReviewScript = "",
    [string]$OutputPath = ""
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

function Get-ItemStatus {
    param([object]$Item)

    $prop = $Item.PSObject.Properties |
        Where-Object { $_.Name -ieq "status" } |
        Select-Object -First 1

    if ($null -eq $prop -or $null -eq $prop.Value) {
        return ""
    }

    return [string]$prop.Value
}

if ([string]::IsNullOrWhiteSpace($SingleReviewScript)) {
    $SingleReviewScript = Join-Path $PSScriptRoot "OS2sofd-find-loesningsreview.ps1"
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $PSScriptRoot "OS2sofd-loesningsreview-input.json"
}

if (-not (Test-Path -LiteralPath $SingleReviewScript)) {
    throw "Kunne ikke finde det eksisterende enkeltsags-script: $SingleReviewScript"
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) blev ikke fundet."
}

Write-Host ""
Write-Host "OS2sofd - find reviewbehov" -ForegroundColor Cyan
Write-Host "Project: $Owner / #$ProjectNumber"
Write-Host "Status:  $TargetStatus"
Write-Host ""

$project = Invoke-GhJson -Arguments @(
    "project", "item-list",
    "$ProjectNumber",
    "--owner", "$Owner",
    "--limit", "1000",
    "--format", "json"
)

$items = @(
    $project.items |
    Where-Object {
        $_.content.repository -eq "$Owner/$Repo" -and
        $null -ne $_.content.number -and
        (Get-ItemStatus $_) -eq $TargetStatus
    } |
    Sort-Object { [int]$_.content.number }
)

Write-Host "Fundet $($items.Count) issue(s) i '$TargetStatus'." -ForegroundColor Cyan
Write-Host ""

# Kør enkeltsags-generatoren i en separat PowerShell-proces.
# Det er vigtigt, fordi enkeltsags-scriptet selv kan afslutte med 'exit 0',
# når et issue allerede er reviewet uden nye kommentarer.
$pwshExe = (Get-Process -Id $PID).Path

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("os2sofd-review-batch-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

$reviewItems = @()
$firstReviewCount = 0
$followUpCount = 0
$noActionCount = 0
$errorCount = 0
$errors = @()

try {
    foreach ($item in $items) {
        $number = [int]$item.content.number
        $title = [string]$item.content.title
        $tempFile = Join-Path $tempRoot ("issue-{0}.json" -f $number)

        Write-Host "Kontrollerer issue #${number}: $title" -ForegroundColor DarkGray

        $processOutput = & $pwshExe `
            -NoProfile `
            -File $SingleReviewScript `
            -IssueNumber $number `
            -Owner $Owner `
            -Repo $Repo `
            -ProjectNumber $ProjectNumber `
            -OutputPath $tempFile 2>&1

        $exitCode = $LASTEXITCODE

        if ($exitCode -ne 0) {
            $errorCount++
            $errorText = ($processOutput -join "`n").Trim()

            $errors += [pscustomobject]@{
                issue_number = $number
                title        = $title
                exit_code    = $exitCode
                message      = $errorText
            }

            Write-Warning "Issue #$number kunne ikke behandles."
            continue
        }

        if (-not (Test-Path -LiteralPath $tempFile)) {
            $noActionCount++
            Write-Host "  Ingen reviewhandling nødvendig." -ForegroundColor Green
            continue
        }

        $reviewInput = Get-Content -LiteralPath $tempFile -Raw -Encoding UTF8 | ConvertFrom-Json

        $previousReviewCount = 0
        if ($null -ne $reviewInput.review_state -and $null -ne $reviewInput.review_state.previous_review_count) {
            $previousReviewCount = [int]$reviewInput.review_state.previous_review_count
        }

        if ($previousReviewCount -eq 0) {
            $reviewType = "first_review"
            $firstReviewCount++
            Write-Host "  Medtages: mangler første PO-review." -ForegroundColor Yellow
        }
        else {
            $reviewType = "follow_up_candidate"
            $followUpCount++
            Write-Host "  Medtages: nye kommentarer efter seneste review." -ForegroundColor Yellow
        }

        $reviewItems += [pscustomobject]@{
            issue_number = $number
            title        = $title
            review_type  = $reviewType
            input        = $reviewInput
        }
    }

    $result = [ordered]@{
        schema_version = "1.0"
        generated_at   = (Get-Date).ToString("o")
        repository     = "$Owner/$Repo"
        project        = [ordered]@{
            owner  = $Owner
            number = $ProjectNumber
            status = $TargetStatus
        }
        summary = [ordered]@{
            issues_in_target_status = $items.Count
            review_candidates       = $reviewItems.Count
            first_reviews           = $firstReviewCount
            follow_up_candidates    = $followUpCount
            no_action_needed        = $noActionCount
            errors                  = $errorCount
        }
        items  = @($reviewItems)
        errors = @($errors)
    }

    $json = $result | ConvertTo-Json -Depth 30
    [System.IO.File]::WriteAllText($OutputPath, $json, $Utf8NoBom)

    Write-Host ""
    Write-Host "Resultat" -ForegroundColor Cyan
    Write-Host "  Issues i '$TargetStatus': $($items.Count)"
    Write-Host "  Reviewkandidater:        $($reviewItems.Count)"
    Write-Host "    Første review:         $firstReviewCount"
    Write-Host "    Opfølgende kandidater: $followUpCount"
    Write-Host "  Ingen handling:          $noActionCount"
    Write-Host "  Fejl:                    $errorCount"
    Write-Host ""
    Write-Host "Samlet review-input gemt:" -ForegroundColor Green
    Write-Host "  $OutputPath"

    if ($reviewItems.Count -eq 0) {
        Write-Host ""
        Write-Host "Der er ingen issues, som aktuelt kræver PO-review." -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "Upload denne ene JSON-fil til ChatGPT for samlet PO-review." -ForegroundColor Cyan
    }
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}
