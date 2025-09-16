# E-Voting App - Development Guide

## Quick Start

### 1. Start Development Environment
```bash
./scripts/dev-start.sh
```

### 2. Access Applications
- **Vote App**: http://localhost:8082 (Pizza vs Burger in dev mode)
- **Results App**: http://localhost:8083
- **Database**: localhost:5432 (postgres/postgres)
- **Redis**: localhost:6379

### 3. View Logs
```bash
# All services
./scripts/dev-logs.sh

# Specific service
./scripts/dev-logs.sh vote
./scripts/dev-logs.sh result
./scripts/dev-logs.sh worker
```

### 4. Test Services
```bash
./scripts/dev-test.sh
```

## Development Features

### Hot Reloading
- **Vote App (Python)**: Changes to `vote/` directory auto-reload
- **Result App (Node.js)**: Changes to `result/` directory auto-reload  
- **Worker App (C#)**: Requires rebuild for changes

### Making Code Changes

#### Vote App (Python/Flask)
```bash
# Edit files in vote/ directory
vim vote/app.py
vim vote/templates/index.html

# Changes auto-reload, check logs:
./scripts/dev-logs.sh vote
```

#### Result App (Node.js)
```bash
# Edit files in result/ directory  
vim result/server.js
vim result/views/index.html

# Changes auto-reload, check logs:
./scripts/dev-logs.sh result
```

#### Worker App (C#)
```bash
# Edit files in worker/ directory
vim worker/Program.cs

# Rebuild required:
docker compose up --build worker -d
```

### Database Access

#### PostgreSQL
```bash
# Connect to database
docker compose exec db psql -U postgres -d postgres

# View votes table
SELECT * FROM votes;
```

#### Redis
```bash
# Connect to Redis
docker compose exec redis redis-cli

# View vote queue
LLEN votes
LRANGE votes 0 -1
```

## Debugging

### Service Status
```bash
docker compose ps
```

### Service Logs
```bash
# Real-time logs
docker compose logs -f vote
docker compose logs -f result
docker compose logs -f worker

# Recent logs
docker compose logs --tail=50 vote
```

### Restart Single Service
```bash
docker compose restart vote
docker compose restart result
docker compose restart worker
```

### Rebuild Service
```bash
docker compose up --build vote -d
docker compose up --build result -d
docker compose up --build worker -d
```

## Environment Configuration

### Development (.env.development)
- Custom vote options: Pizza vs Burger
- Debug mode enabled
- Hot reloading enabled
- Database ports exposed

### Production (.env)
- Standard vote options: Cats vs Dogs
- Production optimizations
- No debug mode

## Common Development Tasks

### Add New Vote Options
1. Edit `.env.development`:
   ```
   OPTION_A=Coffee
   OPTION_B=Tea
   ```
2. Restart: `./scripts/dev-start.sh`

### Test Vote Flow
1. Vote at http://localhost:8082
2. Check results at http://localhost:8083
3. Monitor logs: `./scripts/dev-logs.sh worker`

### Reset Database
```bash
docker compose down -v
./scripts/dev-start.sh
```

## Troubleshooting

### Port Conflicts
- Vote app uses 8082 (not 8080 due to Jenkins)
- Result app uses 8083 (not 8081 due to nginx)

### Service Won't Start
```bash
# Check logs
./scripts/dev-logs.sh [service-name]

# Rebuild
docker compose up --build [service-name] -d
```

### Database Connection Issues
```bash
# Check database status
./scripts/dev-test.sh

# Reset database
docker compose down -v
docker compose up db -d
```