Write-Host "🚀 Starting production environment..." -ForegroundColor Cyan

# Navigate to class2 directory
Set-Location $PSScriptRoot\..

# Start production stack
docker-compose up -d

# Wait for app to be ready
Write-Host "⏳ Waiting for application to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Start monitoring stack
Write-Host "📊 Starting monitoring stack..." -ForegroundColor Yellow
docker-compose -f docker-compose.monitoring.yml up -d

Write-Host ""
Write-Host "✅ Production environment started!" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Application:" -ForegroundColor Yellow
Write-Host "   Frontend:    http://localhost"
Write-Host "   Backend API: http://localhost:3000"
Write-Host ""
Write-Host "📊 Monitoring:" -ForegroundColor Yellow
Write-Host "   Grafana:     http://localhost:3001 (admin/admin)"
Write-Host "   Prometheus:  http://localhost:9090"
Write-Host "   Loki:        http://localhost:3100"
Write-Host ""
Write-Host "💡 To view logs: docker-compose logs -f" -ForegroundColor Cyan
Write-Host "💡 To stop all: docker-compose down; docker-compose -f docker-compose.monitoring.yml down" -ForegroundColor Cyan
