#!/bin/bash
# Development testing script

echo "🧪 Testing E-Voting App..."

# Test vote endpoint
echo "🗳️  Testing Vote App..."
VOTE_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8082)
if [ "$VOTE_RESPONSE" = "200" ]; then
    echo "✅ Vote App: OK"
else
    echo "❌ Vote App: Failed (HTTP $VOTE_RESPONSE)"
fi

# Test result endpoint  
echo "📊 Testing Result App..."
RESULT_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8083)
if [ "$RESULT_RESPONSE" = "200" ]; then
    echo "✅ Result App: OK"
else
    echo "❌ Result App: Failed (HTTP $RESULT_RESPONSE)"
fi

# Test database connection
echo "🗄️  Testing Database..."
DB_TEST=$(docker compose exec -T db pg_isready -U postgres 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "✅ Database: OK"
else
    echo "❌ Database: Failed"
fi

# Test Redis connection
echo "🔴 Testing Redis..."
REDIS_TEST=$(docker compose exec -T redis redis-cli ping 2>/dev/null)
if [ "$REDIS_TEST" = "PONG" ]; then
    echo "✅ Redis: OK"
else
    echo "❌ Redis: Failed"
fi

echo ""
echo "🔗 Application URLs:"
echo "   Vote:    http://localhost:8082"
echo "   Results: http://localhost:8083"