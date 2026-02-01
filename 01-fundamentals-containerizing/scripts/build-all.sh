#!/bin/bash

echo "🐳 Building all Docker images..."

# Install dependencies to generate package-lock.json files
echo "📦 Installing dependencies..."
cd ../backend
npm install
cd ../frontend
npm install
cd ../01-fundamentals-containerizing/scripts

# Build backend
echo "🔨 Building backend image..."
docker build -t bmi-backend:latest ../../backend

# Build frontend
echo "🔨 Building frontend image..."
docker build -t bmi-frontend:latest ../../frontend

echo "✅ All images built successfully!"
docker images | grep bmi
