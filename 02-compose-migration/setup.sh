#!/bin/bash
# Class 2 Setup Script - Copy docker-compose files and configs

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║         CLASS 2 SETUP - Copying Docker Compose Files      ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

CLASS_FOLDER="$(cd "$(dirname "$0")" && pwd)"
ROOT_FOLDER="$(dirname "$CLASS_FOLDER")"

echo " Copying docker-compose and configuration files..."
echo ""

# Copy docker-compose files
echo " Docker Compose files:"
cp "$CLASS_FOLDER/docker-compose.yml" "$ROOT_FOLDER/"
echo "   docker-compose.yml"

cp "$CLASS_FOLDER/docker-compose.dev.yml" "$ROOT_FOLDER/"
echo "   docker-compose.dev.yml"

cp "$CLASS_FOLDER/docker-compose.monitoring.yml" "$ROOT_FOLDER/"
echo "   docker-compose.monitoring.yml"

cp "$CLASS_FOLDER/.env.example" "$ROOT_FOLDER/"
echo "   .env.example"

# Copy monitoring configs
echo ""
echo " Monitoring configurations:"
mkdir -p "$ROOT_FOLDER/monitoring"

cp "$CLASS_FOLDER/monitoring/prometheus.yml" "$ROOT_FOLDER/monitoring/"
echo "   prometheus.yml"

cp "$CLASS_FOLDER/monitoring/loki-config.yml" "$ROOT_FOLDER/monitoring/"
echo "   loki-config.yml"

cp "$CLASS_FOLDER/monitoring/promtail-config.yml" "$ROOT_FOLDER/monitoring/"
echo "   promtail-config.yml"

cp "$CLASS_FOLDER/monitoring/grafana-datasources.yml" "$ROOT_FOLDER/monitoring/"
echo "   grafana-datasources.yml"

# Copy helper scripts
echo ""
echo " Helper scripts:"
cp "$CLASS_FOLDER/start.ps1" "$ROOT_FOLDER/"
echo "   start.ps1"

cp "$CLASS_FOLDER/start.sh" "$ROOT_FOLDER/"
chmod +x "$ROOT_FOLDER/start.sh"
echo "   start.sh"

cp "$CLASS_FOLDER/stop.ps1" "$ROOT_FOLDER/"
echo "   stop.ps1"

cp "$CLASS_FOLDER/stop.sh" "$ROOT_FOLDER/"
chmod +x "$ROOT_FOLDER/stop.sh"
echo "   stop.sh"

echo ""
echo " Setup complete! Ready for Docker Compose orchestration."
echo ""
echo " Next steps:"
echo "   1. Create .env file: cp .env.example .env"
echo "   2. Start services: ./start.sh"
echo "   3. After class, run: ./cleanup.sh to remove files"
echo ""
