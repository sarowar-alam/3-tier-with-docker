#!/bin/bash
# Class 1 Cleanup Script - Remove Docker files from application folders

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║            CLASS 1 CLEANUP - Removing Docker Files         ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

CLASS_FOLDER="$(cd "$(dirname "$0")" && pwd)"
ROOT_FOLDER="$(dirname "$CLASS_FOLDER")"

echo " Removing Docker files from application folders..."
echo ""

# Remove backend files
echo " Backend folder:"
[ -f "$ROOT_FOLDER/backend/Dockerfile" ] && rm "$ROOT_FOLDER/backend/Dockerfile" && echo "   Removed Dockerfile"
[ -f "$ROOT_FOLDER/backend/Dockerfile.dev" ] && rm "$ROOT_FOLDER/backend/Dockerfile.dev" && echo "   Removed Dockerfile.dev"
[ -f "$ROOT_FOLDER/backend/.dockerignore" ] && rm "$ROOT_FOLDER/backend/.dockerignore" && echo "   Removed .dockerignore"

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
