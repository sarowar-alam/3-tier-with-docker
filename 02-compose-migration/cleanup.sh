#!/bin/bash
# Class 2 Cleanup Script - Remove docker-compose files and configs

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║       CLASS 2 CLEANUP - Removing Docker Compose Files     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

CLASS_FOLDER="$(cd "$(dirname "$0")" && pwd)"
ROOT_FOLDER="$(dirname "$CLASS_FOLDER")"

echo " Removing docker-compose and configuration files..."
echo ""

# Stop any running containers first
echo " Stopping any running containers..."
cd "$ROOT_FOLDER"
docker-compose down -v 2>/dev/null || true
echo "   Containers stopped"

# Remove docker-compose files
echo ""
echo " Docker Compose files:"
[ -f "$ROOT_FOLDER/docker-compose.yml" ] && rm "$ROOT_FOLDER/docker-compose.yml" && echo "   Removed docker-compose.yml"
[ -f "$ROOT_FOLDER/docker-compose.dev.yml" ] && rm "$ROOT_FOLDER/docker-compose.dev.yml" && echo "   Removed docker-compose.dev.yml"
[ -f "$ROOT_FOLDER/docker-compose.monitoring.yml" ] && rm "$ROOT_FOLDER/docker-compose.monitoring.yml" && echo "   Removed docker-compose.monitoring.yml"
[ -f "$ROOT_FOLDER/.env" ] && rm "$ROOT_FOLDER/.env" && echo "   Removed .env"
[ -f "$ROOT_FOLDER/.env.example" ] && rm "$ROOT_FOLDER/.env.example" && echo "   Removed .env.example"

# Remove monitoring folder
echo ""
echo " Monitoring configurations:"
[ -d "$ROOT_FOLDER/monitoring" ] && rm -rf "$ROOT_FOLDER/monitoring" && echo "   Removed monitoring/ folder"

# Remove helper scripts
echo ""
echo " Helper scripts:"
for script in start.ps1 start.sh stop.ps1 stop.sh; do
    [ -f "$ROOT_FOLDER/$script" ] && rm "$ROOT_FOLDER/$script" && echo "   Removed $script"
done

echo ""
echo " Cleanup complete! Docker Compose files removed."
echo ""
echo " For next class:"
echo "   Run: ./setup.sh to prepare for another class"
echo ""
