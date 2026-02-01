# Class 1 Setup Script - Copy Docker files to application folders

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "     CLASS 1 SETUP - Copying Docker Files" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

$classFolder = $PSScriptRoot
$rootFolder = Split-Path -Parent $classFolder

Write-Host "Copying files from class materials to application folders..." -ForegroundColor Yellow
Write-Host ""

# Copy backend files
Write-Host "Backend files:" -ForegroundColor Cyan
Copy-Item "$classFolder\backend\Dockerfile" "$rootFolder\backend\" -Force
Write-Host "  [OK] Dockerfile" -ForegroundColor Green

Copy-Item "$classFolder\backend\Dockerfile.dev" "$rootFolder\backend\" -Force
Write-Host "  [OK] Dockerfile.dev" -ForegroundColor Green

Copy-Item "$classFolder\backend\.dockerignore" "$rootFolder\backend\" -Force
Write-Host "  [OK] .dockerignore" -ForegroundColor Green

Copy-Item "$classFolder\backend\db.js" "$rootFolder\backend\src\db.js" -Force
Write-Host "  [OK] db.js with retry logic" -ForegroundColor Green

Copy-Item "$classFolder\backend\.env.example" "$rootFolder\backend\.env" -Force
Write-Host "  [OK] .env (from .env.example)" -ForegroundColor Green

# Copy frontend files
Write-Host ""
Write-Host "Frontend files:" -ForegroundColor Cyan
Copy-Item "$classFolder\frontend\Dockerfile" "$rootFolder\frontend\" -Force
Write-Host "  [OK] Dockerfile" -ForegroundColor Green

Copy-Item "$classFolder\frontend\Dockerfile.dev" "$rootFolder\frontend\" -Force
Write-Host "  [OK] Dockerfile.dev" -ForegroundColor Green

Copy-Item "$classFolder\frontend\.dockerignore" "$rootFolder\frontend\" -Force
Write-Host "  [OK] .dockerignore" -ForegroundColor Green

Copy-Item "$classFolder\frontend\nginx.conf" "$rootFolder\frontend\" -Force
Write-Host "  [OK] nginx.conf" -ForegroundColor Green

Write-Host ""
Write-Host "Setup complete! Application is ready for Docker containerization." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "   1. Navigate to backend/ or frontend/ folder"
Write-Host "   2. Build Docker images: docker build -t image-name ."
Write-Host "   3. After class, run: .\cleanup.ps1 to revert changes"
Write-Host ""
