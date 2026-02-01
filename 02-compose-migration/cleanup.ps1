# Class 2 Cleanup Script - Remove docker-compose files and configs

Write-Host ""
Write-Host "================================================================" -ForegroundColor Yellow
Write-Host "     CLASS 2 CLEANUP - Removing Docker Compose Files" -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Yellow
Write-Host ""

$classFolder = $PSScriptRoot
$rootFolder = Split-Path -Parent $classFolder

Write-Host "Removing docker-compose and configuration files..." -ForegroundColor Yellow
Write-Host ""

# Stop any running containers first
Write-Host "Stopping any running containers..." -ForegroundColor Cyan
Push-Location $rootFolder
docker-compose down -v 2>$null
Pop-Location
Write-Host "  [OK] Containers stopped" -ForegroundColor Green

# Remove docker-compose files
Write-Host ""
Write-Host "Docker Compose files:" -ForegroundColor Cyan
if (Test-Path "$rootFolder\docker-compose.yml") {
    Remove-Item "$rootFolder\docker-compose.yml" -Force
    Write-Host "  [OK] Removed docker-compose.yml" -ForegroundColor Green
}
if (Test-Path "$rootFolder\docker-compose.dev.yml") {
    Remove-Item "$rootFolder\docker-compose.dev.yml" -Force
    Write-Host "  [OK] Removed docker-compose.dev.yml" -ForegroundColor Green
}
if (Test-Path "$rootFolder\docker-compose.monitoring.yml") {
    Remove-Item "$rootFolder\docker-compose.monitoring.yml" -Force
    Write-Host "  [OK] Removed docker-compose.monitoring.yml" -ForegroundColor Green
}
if (Test-Path "$rootFolder\.env") {
    Remove-Item "$rootFolder\.env" -Force
    Write-Host "  [OK] Removed .env" -ForegroundColor Green
}
if (Test-Path "$rootFolder\.env.example") {
    Remove-Item "$rootFolder\.env.example" -Force
    Write-Host "  [OK] Removed .env.example" -ForegroundColor Green
}

# Remove monitoring folder
Write-Host ""
Write-Host "Monitoring configurations:" -ForegroundColor Cyan
if (Test-Path "$rootFolder\monitoring") {
    Remove-Item "$rootFolder\monitoring" -Recurse -Force
    Write-Host "  [OK] Removed monitoring/ folder" -ForegroundColor Green
}

# Remove helper scripts
Write-Host ""
Write-Host "Helper scripts:" -ForegroundColor Cyan
@("start.ps1", "start.sh", "stop.ps1", "stop.sh") | ForEach-Object {
    if (Test-Path "$rootFolder\$_") {
        Remove-Item "$rootFolder\$_" -Force
        Write-Host "  [OK] Removed $_" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Cleanup complete! Docker Compose files removed." -ForegroundColor Green
Write-Host ""
Write-Host "For next class:" -ForegroundColor Yellow
Write-Host "   Run: .\setup.ps1 to prepare for another class"
Write-Host ""
