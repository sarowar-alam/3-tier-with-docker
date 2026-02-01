Write-Host "🛑 Stopping all services..." -ForegroundColor Yellow

# Navigate to class2 directory
Set-Location $PSScriptRoot\..

# Stop monitoring stack
Write-Host "📊 Stopping monitoring stack..." -ForegroundColor Cyan
docker-compose -f docker-compose.monitoring.yml down

# Stop application stack
Write-Host "🌐 Stopping application stack..." -ForegroundColor Cyan
docker-compose down

# Stop development stack if running
Write-Host "🔧 Stopping development stack (if running)..." -ForegroundColor Cyan
docker-compose -f docker-compose.dev.yml down

Write-Host ""
Write-Host "✅ All services stopped!" -ForegroundColor Green
Write-Host ""
Write-Host "💡 To remove volumes as well, run:" -ForegroundColor Cyan
Write-Host "   docker-compose down -v" -ForegroundColor Gray
