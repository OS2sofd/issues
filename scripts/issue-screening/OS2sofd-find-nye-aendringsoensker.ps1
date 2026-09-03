param(
    [string]$Repo = "OS2sofd/issues",
    [string]$ProjectOwner = "OS2sofd",
    [int]$ProjectNumber = 1,

    [string]$OutputPath = (Join-Path $env:USERPROFILE "Downloads\OS2sofd-nye-aendringsoensker.json")
)

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[Console]::InputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom
$ErrorActionPreference = "Stop"

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

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) blev ikke fundet."
}

& gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
    throw "GitHub CLI er ikke logget ind. Kør: gh auth login"
}

Write-Host ""
Write-Host "Finder nye OS2sofd-ændringsønsker..." -ForegroundColor Cyan

# Ét Project-opslag.
$project = Run-GhJson @(
    "project","item-list","$ProjectNumber",
    "--owner",$ProjectOwner,
    "--limit","200",
    "--format","json"
)

$items = @(
    $project.items |
    Where-Object {
        $_.content.repository -eq $Repo -and
        $_.status -eq "Nye ændringsønsker"
    } |
    Sort-Object { [int]$_.content.number }
)

Write-Host "Fundet $($items.Count) issue(s) i 'Nye ændringsønsker'."

$result = @()

foreach ($item in $items) {
    $n = [int]$item.content.number
    Write-Host "  Henter #$n - $($item.content.title)"

    # REST bruges for at spare GraphQL.
    $issue = Run-GhJson @("api","repos/$Repo/issues/$n")
    $comments = @(Run-GhJson @("api","repos/$Repo/issues/$n/comments?per_page=100"))

    $result += [PSCustomObject]@{
        projectStatus = [string]$item.status
        number        = $n
        title         = [string]$issue.title
        body          = [string]$issue.body
        labels        = @($issue.labels | ForEach-Object { $_.name })
        comments      = $comments
        url           = [string]$issue.html_url
    }
}

$json = $result | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($OutputPath, $json, $Utf8NoBom)

Write-Host ""
Write-Host "Færdig." -ForegroundColor Green
Write-Host "Fil: $OutputPath"
Write-Host "Antal nye ændringsønsker: $($result.Count)"
