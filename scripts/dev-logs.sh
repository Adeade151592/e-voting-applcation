#!/bin/bash
# Development logging script

echo "📝 E-Voting App Development Logs"
echo "================================"
echo ""

if [ "$1" ]; then
    echo "🔍 Showing logs for: $1"
    docker compose logs -f "$1"
else
    echo "📋 Available services:"
    echo "  - vote"
    echo "  - result" 
    echo "  - worker"
    echo "  - db"
    echo "  - redis"
    echo ""
    echo "Usage: $0 [service-name]"
    echo "Example: $0 vote"
    echo ""
    echo "🔍 Showing all logs:"
    docker compose logs -f
fi