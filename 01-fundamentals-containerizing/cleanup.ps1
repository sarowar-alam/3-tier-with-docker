# Class 1 Cleanup Script - Remove Docker files from application folders

Write-Host ""
Write-Host "================================================================" -ForegroundColor Yellow
Write-Host "     CLASS 1 CLEANUP - Removing Docker Files" -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Yellow
Write-Host ""

$classFolder = $PSScriptRoot
$rootFolder = Split-Path -Parent $classFolder

Write-Host "Removing Docker files from application folders..." -ForegroundColor Yellow
Write-Host ""

# Remove backend files
Write-Host "Backend folder:" -ForegroundColor Cyan
if (Test-Path "$rootFolder\backend\Dockerfile") {
    Remove-Item "$rootFolder\backend\Dockerfile" -Force
    Write-Host "  [OK] Removed Dockerfile" -ForegroundColor Green
}
if (Test-Path "$rootFolder\backend\Dockerfile.dev") {
    Remove-Item "$rootFolder\backend\Dockerfile.dev" -Force
    Write-Host "  [OK] Removed Dockerfile.dev" -ForegroundColor Green
}
if (Test-Path "$rootFolder\backend\.dockerignore") {
    Remove-Item "$rootFolder\backend\.dockerignore" -Force
    Write-Host "  [OK] Removed .dockerignore" -ForegroundColor Green
}

Write-Host "  [NOTE] db.js kept - has retry logic improvements" -ForegroundColor Yellow

# Remove frontend files
Write-Host ""
Write-Host "Frontend folder:" -ForegroundColor Cyan
if (Test-Path "$rootFolder\frontend\Dockerfile") {
    Remove-Item "$rootFolder\frontend\Dockerfile" -Force
    Write-Host "  [OK] Removed Dockerfile" -ForegroundColor Green
}
if (Test-Path "$rootFolder\frontend\Dockerfile.dev") {
    Remove-Item "$rootFolder\frontend\Dockerfile.dev" -Force
    Write-Host "  [OK] Removed Dockerfile.dev" -ForegroundColor Green
}
if (Test-Path "$rootFolder\frontend\.dockerignore") {
    Remove-Item "$rootFolder\frontend\.dockerignore" -Force
    Write-Host "  [OK] Removed .dockerignore" -ForegroundColor Green
}
if (Test-Path "$rootFolder\frontend\nginx.conf") {
    Remove-Item "$rootFolder\frontend\nginx.conf" -Force
    Write-Host "  [OK] Removed nginx.conf" -ForegroundColor Green
}

Write-Host ""
Write-Host "Cleanup complete! Application folders restored." -ForegroundColor Green
Write-Host ""
Write-Host "For next class:" -ForegroundColor Yellow
Write-Host "   Run: .\setup.ps1 to prepare for another class"
Write-Host ""
