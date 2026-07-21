# add dicomNodes.xml to Weasis default config
# run as administrator

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Error: should run as Administrator" -ForegroundColor Red
    exit 1
}

$destPath = "C:\Program Files\Weasis\app\resources"
$destFile1 = Join-Path $destPath "dicomNodes.xml"
$destFile2 = Join-Path $destPath "dicomCallingNodes.xml"

if (-not (Test-Path $destPath)) {
    Write-Host "Such nonsens, no directory: $destPath" -ForegroundColor Yellow
    exit 1 
}

if (Test-Path $destFile1) {
    Write-Host "File already exist" -ForegroundColor Yellow
    exit 1 
}


Write-Host "copy dicomNodes.xml in $destPath..." -ForegroundColor Cyan

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceFile = Join-Path $scriptDir "dicomNodes.xml"

if (Test-Path $sourceFile) {
    Copy-Item $sourceFile $destFile1 -Force
    Copy-Item $sourceFile $destFile2 -Force
    Write-Host "success" -ForegroundColor Green
} else {
    Write-Host "file dicomNodes.xml not found in sript directory: $scriptDir" -ForegroundColor Red
    exit 1
}

if ((Test-Path $destFile1) and (Test-Path $destFile2)) {
    Write-Host "`nSuccess! Files was added:" -ForegroundColor Green
    Write-Host " - $destFile1" -ForegroundColor Magenta
    Write-Host " - $destFile2" -ForegroundColor Magenta
    Write-Host "This settings will be aplied for all Weasis users." -ForegroundColor Cyan
} else {
    Write-Host "Error during copying try again" -ForegroundColor Red
    exit 1
}