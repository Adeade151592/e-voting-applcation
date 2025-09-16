#!/bin/bash
# Integration tests for e-voting app

echo "🧪 Running Integration Tests..."

# Test vote submission
echo "📝 Testing vote submission..."
VOTE_RESPONSE=$(curl -s -X POST -d "vote=a" http://localhost:8082)
if [[ $? -eq 0 ]]; then
    echo "✅ Vote submission: PASS"
else
    echo "❌ Vote submission: FAIL"
    exit 1
fi

# Wait for vote processing
echo "⏳ Waiting for vote processing..."
sleep 3

# Check vote logs for vote processing
echo "🔍 Checking vote processing..."
if docker compose logs vote | grep -q "Vote received\|🗳️"; then
    echo "✅ Vote processing: PASS"
else
    echo "❌ Vote processing: FAIL"
    exit 1
fi

# Test results page
echo "📊 Testing results page..."
RESULT_RESPONSE=$(curl -s http://localhost:8083)
if [[ $? -eq 0 ]] && echo "$RESULT_RESPONSE" | grep -q "Pizza\|Burger"; then
    echo "✅ Results page: PASS"
else
    echo "❌ Results page: FAIL"
    exit 1
fi

echo "🎉 All integration tests passed!"