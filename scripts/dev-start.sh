#!/bin/bash
# Development startup script

echo "🚀 Starting E-Voting App in Development Mode..."

# Copy development environment
cp .env.development .env

# Start services in development mode
docker compose down
docker compose up --build -d

echo "⏳ Waiting for services to be ready..."
sleep 10

# Check service health
echo "🔍 Checking service status..."
docker compose ps

echo ""
echo "✅ Development environment ready!"
echo ""
echo "🗳️  Vote App:    http://localhost:8082"
echo "📊 Results App: http://localhost:8083"
echo "🗄️  PostgreSQL:  localhost:5432"
echo "🔴 Redis:       localhost:6380"
echo ""
echo "📝 To view logs: docker compose logs -f [service-name]"
echo "🛑 To stop:      docker compose down"