#!/bin/bash
# Class 1 Cleanup Script - Remove Docker files and containers

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║            CLASS 1 CLEANUP - Complete Cleanup              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

CLASS_FOLDER="$(cd "$(dirname "$0")" && pwd)"
ROOT_FOLDER="$(dirname "$CLASS_FOLDER")"

# Stop and remove Docker containers
echo " Stopping and removing Docker containers..."
for container in bmi-backend-test bmi-frontend-test postgres-bmi; do
    if docker ps -a --format "{{.Names}}" | grep -q "^$container$"; then
        docker stop $container 2>/dev/null
        docker rm $container 2>/dev/null
        echo "   Removed container: $container"
    fi
done

# Remove Docker images
echo ""
echo " Removing locally built Docker images..."
for image in bmi-backend:latest bmi-backend:dev bmi-frontend:latest bmi-frontend:dev; do
    if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "^$image$"; then
        docker rmi $image 2>/dev/null
        echo "   Removed image: $image"
    fi
done

echo ""
echo " Removing Docker files from application folders..."
echo ""

# Remove backend files
echo " Backend folder:"
[ -f "$ROOT_FOLDER/backend/Dockerfile" ] && rm "$ROOT_FOLDER/backend/Dockerfile" && echo "   Removed Dockerfile"
[ -f "$ROOT_FOLDER/backend/Dockerfile.dev" ] && rm "$ROOT_FOLDER/backend/Dockerfile.dev" && echo "   Removed Dockerfile.dev"
[ -f "$ROOT_FOLDER/backend/.dockerignore" ] && rm "$ROOT_FOLDER/backend/.dockerignore" && echo "   Removed .dockerignore"
[ -f "$ROOT_FOLDER/backend/.env" ] && rm "$ROOT_FOLDER/backend/.env" && echo "   Removed .env"

echo "    Note: db.js kept (has retry logic improvements)"

# Remove frontend files
echo ""
echo " Frontend folder:"
[ -f "$ROOT_FOLDER/frontend/Dockerfile" ] && rm "$ROOT_FOLDER/frontend/Dockerfile" && echo "   Removed Dockerfile"
[ -f "$ROOT_FOLDER/frontend/Dockerfile.dev" ] && rm "$ROOT_FOLDER/frontend/Dockerfile.dev" && echo "   Removed Dockerfile.dev"
[ -f "$ROOT_FOLDER/frontend/.dockerignore" ] && rm "$ROOT_FOLDER/frontend/.dockerignore" && echo "   Removed .dockerignore"
[ -f "$ROOT_FOLDER/frontend/nginx.conf" ] && rm "$ROOT_FOLDER/frontend/nginx.conf" && echo "   Removed nginx.conf"

echo ""
echo " Cleanup complete! Application folders restored."
echo ""
echo " For next class:"
echo "   Run: ./setup.sh to prepare for another class"
echo ""
