Write-Host " Starting development environment..." -ForegroundColor Cyan

# Navigate to class2 directory
Set-Location $PSScriptRoot\..

# Start development stack
docker-compose -f docker-compose.dev.yml up -d

Write-Host ""
Write-Host " Development environment started!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Services:" -ForegroundColor Yellow
Write-Host "   Frontend:    http://localhost:5173"
Write-Host "   Backend:     http://localhost:3000"
Write-Host "   PostgreSQL:  localhost:5432"
Write-Host ""
Write-Host " To view logs: docker-compose -f docker-compose.dev.yml logs -f" -ForegroundColor Cyan
Write-Host " To stop: docker-compose -f docker-compose.dev.yml down" -ForegroundColor Cyan
