param(
    [ValidateSet("DryRun", "Apply")]
    [string]$Mode = "DryRun",

    [string]$ResultPath = "",

    [string]$SingleDeployScript = ""
)

$ErrorActionPreference = "Stop"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom

if ($env:OS -eq "Windows_NT") {
    & chcp 65001 *> $null
}

if ([string]::IsNullOrWhiteSpace($ResultPath)) {
    $ResultPath = Join-Path $PSScriptRoot "OS2sofd-loesningsreview-resultat.json"
}

if ([string]::IsNullOrWhiteSpace($SingleDeployScript)) {
    $SingleDeployScript = Join-Path $PSScriptRoot "OS2sofd-loesningsreview-deploy.ps1"
}

if (-not (Test-Path -LiteralPath $ResultPath)) {
    throw "Kan ikke finde batch-resultatfilen: $ResultPath"
}

if (-not (Test-Path -LiteralPath $SingleDeployScript)) {
    throw "Kan ikke finde enkeltsags-deploy-scriptet: $SingleDeployScript"
}

$batch = Get-Content -LiteralPath $ResultPath -Raw -Encoding UTF8 | ConvertFrom-Json

if ($null -eq $batch.items) {
    throw "Resultatfilen indeholder ikke feltet 'items'."
}

$items = @($batch.items)

Write-Host ""
Write-Host "OS2sofd - batch deploy af PO-reviews" -ForegroundColor Cyan
Write-Host "Mode:        $Mode"
Write-Host "Resultatfil: $ResultPath"
Write-Host "Antal items: $($items.Count)"
Write-Host ""

$deployableItems = @(
    $items | Where-Object {
        $deployableProp = $_.PSObject.Properties |
            Where-Object { $_.Name -eq "deployable" } |
            Select-Object -First 1

        $null -eq $deployableProp -or [bool]$deployableProp.Value
    }
)

$skippedItems = @(
    $items | Where-Object {
        $deployableProp = $_.PSObject.Properties |
            Where-Object { $_.Name -eq "deployable" } |
            Select-Object -First 1

        $null -ne $deployableProp -and -not [bool]$deployableProp.Value
    }
)

Write-Host "Deploybare reviews: $($deployableItems.Count)" -ForegroundColor Cyan
Write-Host "Springes over:      $($skippedItems.Count)" -ForegroundColor Cyan

foreach ($skip in $skippedItems) {
    $reason = [string]$skip.reason
    Write-Host "  #$($skip.issue_number) springes over: $reason" -ForegroundColor Yellow
}

Write-Host ""

if ($deployableItems.Count -eq 0) {
    Write-Host "Ingen deploybare reviews i filen." -ForegroundColor Green
    exit 0
}

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("os2sofd-review-deploy-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

$pwshExe = (Get-Process -Id $PID).Path
$completed = 0
$failed = 0

try {
    foreach ($item in $deployableItems) {
        $issueNumber = [int]$item.issue_number
        $tempFile = Join-Path $tempRoot ("review-{0}.json" -f $issueNumber)

        $json = $item | ConvertTo-Json -Depth 30
        [System.IO.File]::WriteAllText($tempFile, $json, $Utf8NoBom)

        Write-Host ""
        Write-Host "============================================================" -ForegroundColor DarkGray
        Write-Host "Issue #$issueNumber" -ForegroundColor Cyan
        Write-Host "============================================================" -ForegroundColor DarkGray

        $oldPreference = $ErrorActionPreference

        try {
            # Child PowerShell kan skrive på stderr uden at selve processen fejler.
            # Fang outputtet og afgør succes ud fra exit code.
            $ErrorActionPreference = "Continue"

            $childOutput = & $pwshExe `
                -NoProfile `
                -File $SingleDeployScript `
                -ResultPath $tempFile `
                -Mode $Mode 2>&1

            $exitCode = $LASTEXITCODE
        }
        finally {
            $ErrorActionPreference = $oldPreference
        }

        foreach ($line in @($childOutput)) {
            Write-Host $line
        }

        if ($exitCode -ne 0) {
            $failed++
            Write-Host ""
            Write-Host "STOP: Deploy fejlede på issue #$issueNumber." -ForegroundColor Red
            Write-Host "Tidligere issues i batchen kan allerede være behandlet ved Apply." -ForegroundColor Red
            Write-Host "Efter rettelse kan samme batch køres igen; enkeltsags-scriptet beskytter mod dublet-review." -ForegroundColor Yellow
            exit 1
        }

        $completed++
    }
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor DarkGray
Write-Host "Batch færdig" -ForegroundColor Green
Write-Host "  Behandlet:     $completed"
Write-Host "  Sprunget over: $($skippedItems.Count)"
Write-Host "  Fejl:          $failed"

if ($Mode -eq "DryRun") {
    Write-Host ""
    Write-Host "DRY RUN: Ingen ændringer er skrevet til GitHub." -ForegroundColor Yellow
    Write-Host "Hvis alle reviews ser rigtige ud, kør samme kommando med -Mode Apply." -ForegroundColor Cyan
}
else {
    Write-Host ""
    Write-Host "APPLY gennemført." -ForegroundColor Green
    Write-Host "Kør derefter workflowet 'Notificer Klar til prioritering' for at behandle KG-notifikationer." -ForegroundColor Cyan
}
