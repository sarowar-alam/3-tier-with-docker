Write-Host "🐳 Building all Docker images..." -ForegroundColor Cyan

# Build backend
Write-Host "`n Building backend image..." -ForegroundColor Yellow
docker build -t bmi-backend:latest ..\backend

# Build frontend
Write-Host "`n Building frontend image..." -ForegroundColor Yellow
docker build -t bmi-frontend:latest ..\frontend

Write-Host "`n All images built successfully!" -ForegroundColor Green
docker images | Select-String "bmi"
