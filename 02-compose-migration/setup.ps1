# Class 2 Setup Script - Copy docker-compose files and configs

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "     CLASS 2 SETUP - Copying Docker Compose Files" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

$classFolder = $PSScriptRoot
$rootFolder = Split-Path -Parent $classFolder

Write-Host "Copying docker-compose and configuration files..." -ForegroundColor Yellow
Write-Host ""

# Copy docker-compose files
Write-Host "Docker Compose files:" -ForegroundColor Cyan
Copy-Item "$classFolder\docker-compose.yml" "$rootFolder\" -Force
Write-Host "  [OK] docker-compose.yml" -ForegroundColor Green

Copy-Item "$classFolder\docker-compose.dev.yml" "$rootFolder\" -Force
Write-Host "  [OK] docker-compose.dev.yml" -ForegroundColor Green

Copy-Item "$classFolder\docker-compose.monitoring.yml" "$rootFolder\" -Force
Write-Host "  [OK] docker-compose.monitoring.yml" -ForegroundColor Green

Copy-Item "$classFolder\.env.example" "$rootFolder\" -Force
Write-Host "  [OK] .env.example" -ForegroundColor Green

# Copy monitoring configs
Write-Host ""
Write-Host "Monitoring configurations:" -ForegroundColor Cyan
if (-not (Test-Path "$rootFolder\monitoring")) {
    New-Item -ItemType Directory -Path "$rootFolder\monitoring" | Out-Null
}

Copy-Item "$classFolder\monitoring\prometheus.yml" "$rootFolder\monitoring\" -Force
Write-Host "  [OK] prometheus.yml" -ForegroundColor Green

Copy-Item "$classFolder\monitoring\loki-config.yml" "$rootFolder\monitoring\" -Force
Write-Host "  [OK] loki-config.yml" -ForegroundColor Green

Copy-Item "$classFolder\monitoring\promtail-config.yml" "$rootFolder\monitoring\" -Force
Write-Host "  [OK] promtail-config.yml" -ForegroundColor Green

# Copy grafana folder
if (Test-Path "$classFolder\monitoring\grafana") {
    Copy-Item "$classFolder\monitoring\grafana" "$rootFolder\monitoring\" -Recurse -Force
    Write-Host "  [OK] grafana/ folder" -ForegroundColor Green
}

# Copy helper scripts
Write-Host ""
Write-Host "Helper scripts:" -ForegroundColor Cyan
Copy-Item "$classFolder\scripts\prod-up.ps1" "$rootFolder\start.ps1" -Force
Write-Host "  [OK] start.ps1 (from prod-up.ps1)" -ForegroundColor Green

Copy-Item "$classFolder\scripts\prod-up.sh" "$rootFolder\start.sh" -Force
Write-Host "  [OK] start.sh (from prod-up.sh)" -ForegroundColor Green

Copy-Item "$classFolder\scripts\stop-all.ps1" "$rootFolder\stop.ps1" -Force
Write-Host "  [OK] stop.ps1 (from stop-all.ps1)" -ForegroundColor Green

# Create stop.sh if it doesn't exist
if (Test-Path "$classFolder\scripts\stop-all.sh") {
    Copy-Item "$classFolder\scripts\stop-all.sh" "$rootFolder\stop.sh" -Force
} else {
    # Create a basic stop.sh script
    @"
#!/bin/bash
docker-compose down -v
"@ | Set-Content "$rootFolder\stop.sh" -Encoding UTF8
}
Write-Host "  [OK] stop.sh" -ForegroundColor Green

Write-Host ""
Write-Host "Setup complete! Ready for Docker Compose orchestration." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "   1. Create .env file: Copy-Item .env.example .env"
Write-Host "   2. Start services: .\start.ps1"
Write-Host "   3. After class, run: .\cleanup.ps1 to remove files"
Write-Host ""
