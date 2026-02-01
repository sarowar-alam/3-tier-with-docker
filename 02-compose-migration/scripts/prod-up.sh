#!/bin/bash

echo " Starting production environment..."

# Navigate to class2 directory
cd "$(dirname "$0")/.."

# Start production stack
docker-compose up -d

# Wait for app to be ready
echo "⏳ Waiting for application to be ready..."
sleep 10

# Start monitoring stack
echo "📊 Starting monitoring stack..."
docker-compose -f docker-compose.monitoring.yml up -d

echo ""
echo " Production environment started!"
echo ""
echo "🌐 Application:"
echo "   Frontend:    http://localhost"
echo "   Backend API: http://localhost:3000"
echo ""
echo "📊 Monitoring:"
echo "   Grafana:     http://localhost:3001 (admin/admin)"
echo "   Prometheus:  http://localhost:9090"
echo "   Loki:        http://localhost:3100"
echo ""
echo " To view logs: docker-compose logs -f"
echo " To stop all: docker-compose down && docker-compose -f docker-compose.monitoring.yml down"
