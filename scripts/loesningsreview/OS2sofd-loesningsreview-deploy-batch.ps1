param(
    [ValidateSet("DryRun", "Apply")]
    [string]$Mode = "DryRun",

    [string]$ResultPath = "",

    [string]$SingleDeployScript = "",

    [string]$Owner = "OS2sofd",
    [string]$Repo = "issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,
    [string]$EstimateFieldName = "Estimat"
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

    $oldPreference = $ErrorActionPreference

    try {
        $ErrorActionPreference = "Continue"
        $output = & gh @Arguments 2>&1
        $exitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $oldPreference
    }

    $text = ($output -join "`n").Trim()

    if ($exitCode -ne 0) {
        throw "gh fejlede: $text"
    }

    if ([string]::IsNullOrWhiteSpace($text)) {
        return $null
    }

    return $text | ConvertFrom-Json
}

function Get-GraphQlRateLimit {
    # Brug GraphQLs egen rateLimit-status. REST-endpointet /rate_limit kan
    # i praksis vise en anden/stale værdi end den kvote, som gh project bruger.
    $query = 'query { viewer { login } rateLimit { limit remaining used resetAt } }'

    $rateResponse = Invoke-GhJson -Arguments @(
        "api", "graphql",
        "-f", "query=$query"
    )

    $rate = $rateResponse.data.rateLimit

    return [pscustomobject]@{
        Remaining = [int]$rate.remaining
        Limit     = [int]$rate.limit
        Used      = [int]$rate.used
        ResetAt   = [DateTimeOffset]::Parse([string]$rate.resetAt).ToLocalTime()
    }
}

function Get-ItemEstimate {
    param(
        [object]$Item,
        [string]$FieldName
    )

    $prop = $Item.PSObject.Properties |
        Where-Object { $_.Name -ieq $FieldName } |
        Select-Object -First 1

    if ($null -eq $prop -or $null -eq $prop.Value) {
        return ""
    }

    return [string]$prop.Value
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

Write-Host ""
Write-Host "OS2sofd - batch deploy af PO-reviews" -ForegroundColor Cyan
Write-Host "Mode:        $Mode"
Write-Host "Resultatfil: $ResultPath"
Write-Host "Deploybare:  $($deployableItems.Count)"
Write-Host "Springes over: $($skippedItems.Count)"
Write-Host ""

foreach ($skip in $skippedItems) {
    Write-Host "  #$($skip.issue_number) springes over: $($skip.reason)" -ForegroundColor Yellow
}

if ($deployableItems.Count -eq 0) {
    Write-Host "Ingen deploybare reviews i filen." -ForegroundColor Green
    exit 0
}

# DryRun må ikke bruge GraphQL overhovedet. Det viser blot mål-estimatet
# fra review-resultatet. Dermed kan et helt batch-review kontrolleres selv
# når GitHubs GraphQL-kvote er lav eller opbrugt.
if ($Mode -eq "DryRun") {
    Write-Host ""
    Write-Host "DRY RUN: Estimatkontrol bruger ingen GitHub Project/GraphQL-kald." -ForegroundColor DarkGray
}
else {
    # Preflight før noget skrives. Worst case:
    # 3 GraphQL-læsekald (project/fields/items) + ét item-edit pr. estimat.
    $estimateCount = @(
        $deployableItems | Where-Object {
            -not [string]::IsNullOrWhiteSpace([string]$_.estimate)
        }
    ).Count

    $requiredWorstCase = $estimateCount + 3
    $safetyMargin = 5
    $rate = Get-GraphQlRateLimit

    Write-Host ""
    Write-Host "GraphQL-kvote:" -ForegroundColor Cyan
    Write-Host "  Tilbage: $($rate.Remaining) / $($rate.Limit)"
    Write-Host "  Brugt:   $($rate.Used)"
    Write-Host "  Reset:   $($rate.ResetAt.ToString('yyyy-MM-dd HH:mm:ss zzz'))"
    Write-Host "  Behov, worst case: $requiredWorstCase + $safetyMargin sikkerhedsmargin"

    if ($rate.Remaining -lt ($requiredWorstCase + $safetyMargin)) {
        throw "For lidt GraphQL-kvote til sikker Apply. Vent til reset og kør batchen igen. Ingen ændringer er foretaget."
    }
}

# Ved Apply hentes Project metadata og alle items kun én gang.
$projectId = ""
$estimateFieldId = ""
$projectItemsByIssue = @{}

if ($Mode -eq "Apply") {
    $project = Invoke-GhJson -Arguments @(
        "project", "view",
        "$ProjectNumber",
        "--owner", "$ProjectOwner",
        "--format", "json"
    )

    $projectId = [string]$project.id

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

    $estimateFieldId = [string]$field.id

    $projectData = Invoke-GhJson -Arguments @(
        "project", "item-list",
        "$ProjectNumber",
        "--owner", "$ProjectOwner",
        "--format", "json",
        "--limit", "1000"
    )

    foreach ($projectItem in @($projectData.items)) {
        if (
            $projectItem.content.repository -eq "$Owner/$Repo" -and
            $null -ne $projectItem.content.number
        ) {
            $projectItemsByIssue[[int]$projectItem.content.number] = $projectItem
        }
    }
}

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("os2sofd-review-deploy-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

$pwshExe = (Get-Process -Id $PID).Path
$completed = 0
$failed = 0
$estimateUpdates = 0

try {
    foreach ($item in $deployableItems) {
        $issueNumber = [int]$item.issue_number
        $estimate = [string]$item.estimate
        $tempFile = Join-Path $tempRoot ("review-{0}.json" -f $issueNumber)

        Write-Host ""
        Write-Host "============================================================" -ForegroundColor DarkGray
        Write-Host "Issue #$issueNumber" -ForegroundColor Cyan
        Write-Host "============================================================" -ForegroundColor DarkGray

        if ([string]::IsNullOrWhiteSpace($estimate)) {
            Write-Host "Estimat: ingen sikker værdi - Project-feltet ændres ikke." -ForegroundColor Yellow
        }
        elseif ($Mode -eq "DryRun") {
            Write-Host "Estimat: mål-værdi '$estimate'." -ForegroundColor Yellow
            Write-Host "DRY RUN: Estimat ændres ikke." -ForegroundColor Yellow
        }
        else {
            if (-not $projectItemsByIssue.ContainsKey($issueNumber)) {
                throw "Issue #$issueNumber blev ikke fundet i Project #$ProjectNumber."
            }

            $projectItem = $projectItemsByIssue[$issueNumber]
            $currentEstimate = Get-ItemEstimate -Item $projectItem -FieldName $EstimateFieldName

            if ($currentEstimate -eq $estimate) {
                Write-Host "Estimat: Project-feltet er allerede '$estimate'." -ForegroundColor Green
            }
            else {
                if ([string]::IsNullOrWhiteSpace($currentEstimate)) {
                    Write-Host "Estimat: sætter '$EstimateFieldName' til '$estimate'." -ForegroundColor Yellow
                }
                else {
                    Write-Host "Estimat: ændrer '$EstimateFieldName' fra '$currentEstimate' til '$estimate'." -ForegroundColor Yellow
                }

                & gh project item-edit `
                    --id $projectItem.id `
                    --project-id $projectId `
                    --field-id $estimateFieldId `
                    --text $estimate

                if ($LASTEXITCODE -ne 0) {
                    throw "Kunne ikke opdatere Estimat på issue #$issueNumber."
                }

                $estimateUpdates++
            }
        }

        $json = $item | ConvertTo-Json -Depth 30
        [System.IO.File]::WriteAllText($tempFile, $json, $Utf8NoBom)

        $oldPreference = $ErrorActionPreference

        try {
            $ErrorActionPreference = "Continue"

            $childOutput = & $pwshExe `
                -NoProfile `
                -File $SingleDeployScript `
                -ResultPath $tempFile `
                -Mode $Mode `
                -SkipEstimate 2>&1

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

            if ($Mode -eq "Apply") {
                Write-Host "Tidligere issues i batchen kan allerede være behandlet." -ForegroundColor Red
                Write-Host "Efter rettelse kan samme batch køres igen; dubletbeskyttelsen forhindrer dobbelt reviewkommentar." -ForegroundColor Yellow
            }

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
Write-Host "  Behandlet:       $completed"
Write-Host "  Sprunget over:   $($skippedItems.Count)"
Write-Host "  Estimatændringer: $estimateUpdates"
Write-Host "  Fejl:            $failed"

if ($Mode -eq "DryRun") {
    Write-Host ""
    Write-Host "DRY RUN: Ingen ændringer er skrevet til GitHub." -ForegroundColor Yellow
    Write-Host "Hvis alle reviews ser rigtige ud, kør samme kommando med -Mode Apply." -ForegroundColor Cyan
}
else {
    Write-Host ""
    Write-Host "APPLY gennemført." -ForegroundColor Green
    Write-Host "Kør derefter workflowet 'Notificer Klar til prioritering'." -ForegroundColor Cyan
}
