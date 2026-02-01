#!/bin/bash

echo "🐳 Building all Docker images..."

# Build backend
echo " Building backend image..."
docker build -t bmi-backend:latest ../backend

# Build frontend
echo " Building frontend image..."
docker build -t bmi-frontend:latest ../frontend

echo " All images built successfully!"
docker images | grep bmi
