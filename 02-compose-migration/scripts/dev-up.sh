#!/bin/bash

echo "🚀 Starting development environment..."

# Navigate to class2 directory
cd "$(dirname "$0")/.."

# Start development stack
docker-compose -f docker-compose.dev.yml up -d

echo ""
echo "✅ Development environment started!"
echo ""
echo "📊 Services:"
echo "   Frontend:    http://localhost:5173"
echo "   Backend:     http://localhost:3000"
echo "   PostgreSQL:  localhost:5432"
echo ""
echo "💡 To view logs: docker-compose -f docker-compose.dev.yml logs -f"
echo "💡 To stop: docker-compose -f docker-compose.dev.yml down"
