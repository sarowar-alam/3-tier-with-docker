#!/bin/bash
# Class 1 Setup Script - Copy Docker files to application folders

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║            CLASS 1 SETUP - Copying Docker Files            ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

CLASS_FOLDER="$(cd "$(dirname "$0")" && pwd)"
ROOT_FOLDER="$(dirname "$CLASS_FOLDER")"

echo " Copying files from class materials to application folders..."
echo ""

# Copy backend files
echo " Backend files:"
cp "$CLASS_FOLDER/backend/Dockerfile" "$ROOT_FOLDER/backend/"
echo "   Dockerfile"

cp "$CLASS_FOLDER/backend/Dockerfile.dev" "$ROOT_FOLDER/backend/"
echo "   Dockerfile.dev"

cp "$CLASS_FOLDER/backend/.dockerignore" "$ROOT_FOLDER/backend/"
echo "   .dockerignore"

cp "$CLASS_FOLDER/backend/db.js" "$ROOT_FOLDER/backend/src/db.js"
echo "   db.js (with retry logic)"

# Copy frontend files
echo ""
echo " Frontend files:"
cp "$CLASS_FOLDER/frontend/Dockerfile" "$ROOT_FOLDER/frontend/"
echo "   Dockerfile"

cp "$CLASS_FOLDER/frontend/Dockerfile.dev" "$ROOT_FOLDER/frontend/"
echo "   Dockerfile.dev"

cp "$CLASS_FOLDER/frontend/.dockerignore" "$ROOT_FOLDER/frontend/"
echo "   .dockerignore"

cp "$CLASS_FOLDER/frontend/nginx.conf" "$ROOT_FOLDER/frontend/"
echo "   nginx.conf"

echo ""
echo " Setup complete! Application is ready for Docker containerization."
echo ""
echo " Next steps:"
echo "   1. Navigate to backend/ or frontend/ folder"
echo "   2. Build Docker images: docker build -t image-name ."
echo "   3. After class, run: ./cleanup.sh to revert changes"
echo ""
