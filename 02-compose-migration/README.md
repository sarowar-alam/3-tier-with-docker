# Class 2: Docker Compose & Migrating Deployment from VMs to Containers

##  Learning Objectives

By the end of this class, students will:
- Understand Docker Compose for multi-container orchestration
- Manage networks, volumes, and environment variables
- Deploy full 3-tier application stack with Docker Compose
- Migrate database to Docker container
- Implement health checks and container monitoring
- Set up logging with Loki and monitoring with Prometheus & Grafana
- Integrate Docker builds into CI/CD pipelines
- Compare traditional VM deployment vs containerized deployment

---

##  Topics Covered

1. **Docker Compose Fundamentals**
   - Introduction to Docker Compose
   - YAML syntax and structure
   - Service definitions and configurations

2. **Multi-Container Management**
   - Docker networks (bridge, host, overlay)
   - Volume management and persistence
   - Service dependencies and health checks
   - Container restart policies

3. **Database Migration**
   - Containerizing PostgreSQL
   - Running database migrations automatically
   - Data persistence strategies

4. **Environment Management**
   - Environment variables in Docker Compose
   - .env files and secrets
   - Development vs Production configurations

5. **Monitoring & Logging**
   - Prometheus for metrics collection
   - Grafana for visualization
   - Loki for log aggregation
   - Promtail for log collection
   - Container health monitoring

6. **CI/CD Integration**
   - GitHub Actions for Docker builds
   - Automated image building and pushing
   - Deploying containers on AWS EC2

7. **Comparison: VMs vs Containers**
   - Resource utilization
   - Deployment speed
   - Scalability and maintenance

---

##  Files Overview

### Docker Compose Files
```
02-compose-migration/
├── docker-compose.yml              # Production 3-tier stack
├── docker-compose.dev.yml          # Development stack with hot reload
├── docker-compose.monitoring.yml   # Monitoring stack (Prometheus, Grafana, Loki)
├── .env                           # Environment variables
├── .env.example                   # Environment template
└── .gitignore                     # Git ignore patterns
```

### Monitoring Configuration
```
monitoring/
├── prometheus.yml                  # Prometheus scrape configs
├── loki-config.yml                # Loki storage and retention
├── promtail-config.yml            # Log collection from Docker
└── grafana/
    ├── datasources.yml            # Prometheus & Loki datasources
    └── dashboards/
        ├── dashboard.yml          # Dashboard provisioning
        └── bmi-app-dashboard.json # Pre-built dashboard
```

### Helper Scripts
```
scripts/
├── dev-up.ps1                     # Start development environment
├── prod-up.ps1                    # Start production + monitoring
├── stop-all.ps1                   # Stop all services
├── dev-up.sh                      # Linux/Mac version
└── prod-up.sh                     # Linux/Mac version
```

---

##  Getting Started

### Prerequisites

1. **Docker Desktop** installed and running
2. **Class 1 completed** (Dockerfiles created in backend/frontend)
3. **Environment file** configured

### Step 1: Setup Environment

```powershell
# Navigate to 02-compose-migration directory
cd 02-compose-migration

# Copy environment template
Copy-Item .env.example .env

# Edit .env file and update passwords
notepad .env
```

**Important Environment Variables:**
- `POSTGRES_PASSWORD` - Set a strong password
- `GRAFANA_ADMIN_PASSWORD` - Set admin password for Grafana
- `DATABASE_URL` - Auto-constructed from POSTGRES_* variables

---

## 🔨 Running the Application

### Option 1: Development Mode (With Hot Reload)

```powershell
# From 02-compose-migration directory
cd scripts
.\dev-up.ps1

# Or manually
docker-compose -f docker-compose.dev.yml up -d
```

**Development Features:**
-  Vite HMR (Hot Module Replacement) for frontend
-  Nodemon auto-restart for backend
-  Source code mounted as volumes
-  Fast iteration cycle

**Access:**
- Frontend: http://localhost:5173
- Backend API: http://localhost:3000
- PostgreSQL: localhost:5432

### Option 2: Production Mode (With Monitoring)

```powershell
# From 02-compose-migration directory
cd scripts
.\prod-up.ps1

# Or manually
docker-compose up -d
docker-compose -f docker-compose.monitoring.yml up -d
```

**Production Features:**
-  Optimized multi-stage builds
-  Nginx serving frontend
-  Health checks enabled
-  Logging and monitoring
-  Automatic restarts

**Access:**
- Frontend: http://localhost
- Backend API: http://localhost:3000
- Grafana: http://localhost:3001 (admin/admin)
- Prometheus: http://localhost:9090
- Loki: http://localhost:3100

---

## 🐳 Docker Compose Commands

### Basic Operations

```powershell
# Start services in background
docker-compose up -d

# Start specific service
docker-compose up -d backend

# View logs (all services)
docker-compose logs -f

# View logs (specific service)
docker-compose logs -f backend

# Stop services (keep data)
docker-compose stop

# Stop and remove containers (keep data)
docker-compose down

# Stop, remove containers AND volumes (delete data)
docker-compose down -v

# Restart a service
docker-compose restart backend

# Rebuild and restart
docker-compose up -d --build backend
```

### Inspect and Debug

```powershell
# List running services
docker-compose ps

# Execute command in running container
docker-compose exec backend sh
docker-compose exec postgres psql -U bmi_user -d bmidb

# View service configuration
docker-compose config

# View resource usage
docker stats
```

### Scaling (for stateless services)

```powershell
# Scale backend to 3 instances
docker-compose up -d --scale backend=3

# Note: Requires load balancer for production use
```

---

##  Database Management

### Accessing PostgreSQL

```powershell
# Connect to PostgreSQL container
docker-compose exec postgres psql -U bmi_user -d bmidb

# Run SQL commands
\dt                    # List tables
\d measurements        # Describe table
SELECT * FROM measurements LIMIT 10;
\q                     # Quit
```

### Database Migrations

Migrations run automatically on first container start via `docker-entrypoint-initdb.d`:

```yaml
volumes:
  - ../backend/migrations:/docker-entrypoint-initdb.d:ro
```

**Migration Files:**
- `001_create_measurements.sql` - Creates initial schema
- `002_add_measurement_date.sql` - Adds measurement_date column

### Manual Migration

```powershell
# If you need to run migrations manually
docker-compose exec postgres psql -U bmi_user -d bmidb -f /docker-entrypoint-initdb.d/001_create_measurements.sql
```

### Backup and Restore

```powershell
# Backup database
docker-compose exec postgres pg_dump -U bmi_user bmidb > backup.sql

# Restore database
Get-Content backup.sql | docker-compose exec -T postgres psql -U bmi_user -d bmidb
```

---

## 🌐 Docker Networks

### Network Architecture

```
bmi-app-network (bridge)
├── postgres (internal: postgres:5432)
├── backend (internal: backend:3000, external: localhost:3000)
└── frontend (internal: frontend:80, external: localhost:80)

bmi-monitoring-network (bridge)
├── prometheus (internal: prometheus:9090, external: localhost:9090)
├── loki (internal: loki:3100, external: localhost:3100)
├── promtail (collects logs from Docker daemon)
├── grafana (internal: grafana:3000, external: localhost:3001)
├── postgres-exporter (internal: :9187)
└── node-exporter (internal: :9100)
```

### Network Commands

```powershell
# List networks
docker network ls

# Inspect network
docker network inspect bmi-app-network

# View container IPs
docker network inspect bmi-app-network | Select-String "IPv4Address"
```

### Service Discovery

Containers on the same network can reach each other by **service name**:

```javascript
// Backend connects to database
DATABASE_URL: "postgresql://user:pass@postgres:5432/db"
                                      ^^^^^^^^
                                      Service name (not localhost!)

// Nginx proxies to backend
proxy_pass http://backend:3000;
                  ^^^^^^^
                  Service name
```

---

## 💾 Docker Volumes

### Volume Types

1. **Named Volumes** (Recommended for production)
   ```yaml
   volumes:
     postgres-data:
       name: bmi-postgres-data
   ```

2. **Bind Mounts** (Used for development)
   ```yaml
   volumes:
     - ../backend/src:/app/src:ro
   ```

### Volume Commands

```powershell
# List volumes
docker volume ls

# Inspect volume
docker volume inspect bmi-postgres-data

# View volume location
docker volume inspect bmi-postgres-data | Select-String "Mountpoint"

# Remove unused volumes
docker volume prune

# Backup volume data
docker run --rm -v bmi-postgres-data:/data -v ${PWD}:/backup alpine tar czf /backup/postgres-backup.tar.gz /data

# Restore volume data
docker run --rm -v bmi-postgres-data:/data -v ${PWD}:/backup alpine tar xzf /backup/postgres-backup.tar.gz -C /
```

---

##  Health Checks

### Health Check Configuration

```yaml
healthcheck:
  test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost:3000/health"]
  interval: 30s       # Check every 30 seconds
  timeout: 10s        # Fail if takes longer than 10s
  retries: 3          # Try 3 times before marking unhealthy
  start_period: 40s   # Grace period on startup
```

### Checking Health Status

```powershell
# View health status
docker-compose ps

# Detailed health info
docker inspect bmi-backend | Select-String "Health" -Context 5

# View health check logs
docker inspect bmi-backend --format='{{json .State.Health}}' | ConvertFrom-Json
```

### Depends On with Health Checks

```yaml
backend:
  depends_on:
    postgres:
      condition: service_healthy  # Wait until postgres is healthy
```

---

## 📊 Monitoring with Prometheus & Grafana

### Accessing Monitoring Tools

1. **Prometheus** - http://localhost:9090
   - Metrics explorer: Status → Targets
   - Query metrics: Graph → Enter query
   - Example: `up{job="backend"}`

2. **Grafana** - http://localhost:3001
   - Login: admin / admin (change on first login)
   - Datasources: Already configured (Prometheus & Loki)
   - Dashboards: Browse → BMI Application folder

### Sample Prometheus Queries

```promql
# Check if services are up
up{job="backend"}
up{job="postgres"}

# HTTP request rate
rate(http_requests_total[5m])

# Memory usage
container_memory_usage_bytes

# CPU usage
rate(container_cpu_usage_seconds_total[5m])

# Database connections
pg_stat_database_numbackends
```

### Creating Grafana Dashboards

1. Navigate to Dashboards → New Dashboard
2. Add Panel
3. Select Data Source: Prometheus
4. Enter query (e.g., `up{job="backend"}`)
5. Customize visualization
6. Save dashboard

---

## 📝 Logging with Loki

### Accessing Logs

**Via Grafana (Recommended):**
1. Open Grafana: http://localhost:3001
2. Go to Explore
3. Select Loki datasource
4. Query logs:
   ```logql
   {container="bmi-backend"}
   {container="bmi-frontend"}
   {container="bmi-postgres"}
   {service="backend"} |= "error"
   ```

**Via Docker:**
```powershell
# Container logs
docker-compose logs -f backend

# All logs
docker-compose logs -f

# Last 100 lines
docker-compose logs --tail=100 backend
```

### Log Queries (LogQL)

```logql
# All backend logs
{container="bmi-backend"}

# Error logs only
{container="bmi-backend"} |= "error"

# Exclude health checks
{container="bmi-backend"} != "/health"

# Parsed JSON logs
{container="bmi-backend"} | json | level="error"

# Rate of errors
rate({container="bmi-backend"} |= "error" [5m])
```

---

##  CI/CD Integration with GitHub Actions

### GitHub Actions Workflow

Create `.github/workflows/docker-build-push.yml`:

```yaml
name: Build and Push Docker Images

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      
      - name: Build and push backend
        uses: docker/build-push-action@v4
        with:
          context: ./backend
          push: true
          tags: |
            ${{ secrets.DOCKERHUB_USERNAME }}/bmi-backend:latest
            ${{ secrets.DOCKERHUB_USERNAME }}/bmi-backend:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  build-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      
      - name: Build and push frontend
        uses: docker/build-push-action@v4
        with:
          context: ./frontend
          push: true
          tags: |
            ${{ secrets.DOCKERHUB_USERNAME }}/bmi-frontend:latest
            ${{ secrets.DOCKERHUB_USERNAME }}/bmi-frontend:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

### Required GitHub Secrets

1. Go to Repository → Settings → Secrets and variables → Actions
2. Add secrets:
   - `DOCKERHUB_USERNAME` - Your DockerHub username
   - `DOCKERHUB_TOKEN` - DockerHub access token (create at hub.docker.com)

---

##  Deploying on AWS EC2

### 1. Launch EC2 Instance

```powershell
# Using AWS CLI
aws ec2 run-instances `
  --image-id ami-0c55b159cbfafe1f0 `
  --instance-type t2.medium `
  --key-name your-key `
  --security-group-ids sg-xxxxx `
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=bmi-docker-app}]'
```

### 2. Install Docker on EC2

```bash
# SSH into EC2
ssh -i your-key.pem ec2-user@ec2-ip

# Install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 3. Deploy Application

```bash
# Clone repository
git clone https://github.com/yourusername/bmi-app.git
cd bmi-app

# Copy Class 1 files to appropriate locations
cp 01-fundamentals-containerizing/backend/Dockerfile backend/
cp 01-fundamentals-containerizing/frontend/Dockerfile frontend/
# ... (copy other files)

# Navigate to 02-compose-migration
cd 02-compose-migration

# Set up environment
cp .env.example .env
nano .env  # Edit credentials

# Start services
docker-compose up -d
docker-compose -f docker-compose.monitoring.yml up -d
```

### 4. Configure Security Group

Allow inbound traffic:
- Port 80 (HTTP) - Frontend
- Port 3000 - Backend API
- Port 3001 - Grafana
- Port 22 (SSH) - Administration

---

## 📊 VM vs Container Comparison

### Resource Utilization

| Aspect | Traditional VMs | Docker Containers |
|--------|----------------|-------------------|
| **Startup Time** | 2-5 minutes | 2-5 seconds |
| **Memory (3-tier app)** | ~6 GB (3 VMs × 2GB) | ~500 MB total |
| **Disk Space** | ~60 GB (3 VMs × 20GB) | ~500 MB total |
| **CPU Overhead** | High (multiple OS kernels) | Low (shared kernel) |
| **Isolation** | Strong (hypervisor-level) | Process-level |

### Deployment Comparison

**Traditional VM Deployment:**
```
1. Provision 3 VMs (5-10 minutes each)
2. Install OS dependencies on each VM
3. Configure networking between VMs
4. Deploy application on each VM
5. Set up monitoring agents on each VM
Total Time: 2-3 hours
```

**Docker Container Deployment:**
```
1. Pull images (1-2 minutes)
2. Run docker-compose up (30 seconds)
Total Time: 5 minutes
```

### Maintenance

| Task | VMs | Containers |
|------|-----|-----------|
| **OS Updates** | Update 3 separate OS instances | Update base image once |
| **Scaling** | Provision new VMs (minutes) | Start new containers (seconds) |
| **Rollback** | Complex, requires snapshots | Simple: `docker-compose down && docker-compose up` |
| **Environment Parity** | Dev/Prod drift common | Dev = Prod (same images) |

---

##  Common Issues and Solutions

### 1. Port Already in Use

**Error:** `bind: address already in use`

**Solution:**
```powershell
# Find process using port
netstat -ano | findstr :3000

# Kill process
taskkill /PID <pid> /F

# Or use different port in .env
BACKEND_PORT=3001
```

### 2. Database Connection Failed

**Error:** `connection refused` or `could not connect to server`

**Solution:**
- Check if postgres container is healthy: `docker-compose ps`
- Verify DATABASE_URL uses service name `postgres`, not `localhost`
- Check logs: `docker-compose logs postgres`
- Ensure backend waits for postgres with `depends_on` and health check

### 3. Frontend Cannot Reach Backend

**Error:** `Network Error` or `404 Not Found`

**Solution:**
- Check nginx.conf proxy configuration
- Verify backend service is running and healthy
- Test backend directly: `curl http://localhost:3000/health`
- Check Docker network: `docker network inspect bmi-app-network`

### 4. Volume Permission Issues

**Error:** `permission denied` accessing volume

**Solution:**
```powershell
# Remove volumes and recreate
docker-compose down -v
docker-compose up -d

# Or check volume ownership
docker-compose exec postgres ls -la /var/lib/postgresql/data
```

### 5. Container Keeps Restarting

**Solution:**
```powershell
# Check logs for errors
docker-compose logs backend

# Check exit code
docker-compose ps

# Disable health check temporarily to debug
# Comment out healthcheck in docker-compose.yml
```

### 6. Monitoring Stack Not Working

**Solution:**
- Ensure app network exists: `docker network ls`
- Check Prometheus targets: http://localhost:9090/targets
- Verify datasources in Grafana: Configuration → Data Sources
- Check Loki: http://localhost:3100/ready

---

##  Class Activities

### Activity 1: Deploy 3-Tier Stack
1. Start production stack with `docker-compose up -d`
2. Verify all services are healthy
3. Test the application end-to-end
4. View logs from each service

### Activity 2: Network Isolation
1. Inspect the app network
2. Try connecting backend to database using `localhost` (should fail)
3. Use correct service name `postgres` (should work)
4. Understand Docker DNS resolution

### Activity 3: Volume Persistence
1. Add measurements through the app
2. Stop all containers: `docker-compose down`
3. Start containers again: `docker-compose up -d`
4. Verify data persists

### Activity 4: Monitoring Setup
1. Start monitoring stack
2. Access Grafana and login
3. Explore Prometheus datasource
4. Query logs in Loki
5. Create a custom dashboard

### Activity 5: Development Workflow
1. Start dev environment: `docker-compose -f docker-compose.dev.yml up -d`
2. Make changes to backend/frontend code
3. Observe hot reload in action
4. Test changes immediately

### Activity 6: Scaling Experiment
1. Scale backend: `docker-compose up -d --scale backend=3`
2. Observe multiple backend containers
3. Note: Requires load balancer for production

---

## 📝 Homework

1. **Add Redis Caching**
   - Add Redis service to docker-compose.yml
   - Configure backend to use Redis
   - Implement caching for API responses

2. **Create Custom Dashboard**
   - Design Grafana dashboard with:
     - Request rate per endpoint
     - Database connection pool usage
     - Container resource usage
     - Error rate over time

3. **Implement Blue-Green Deployment**
   - Create two identical stacks (blue/green)
   - Script to switch between them
   - Zero-downtime deployment strategy

4. **Add Nginx Load Balancer**
   - Add Nginx service as load balancer
   - Configure upstream backend servers
   - Test load distribution

---

## 🔗 Resources

- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Compose File Reference](https://docs.docker.com/compose/compose-file/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Loki Documentation](https://grafana.com/docs/loki/latest/)
- [GitHub Actions for Docker](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images)

---

##  Class 2 Checklist

- [ ] Understand Docker Compose structure
- [ ] Write docker-compose.yml for 3-tier app
- [ ] Configure Docker networks
- [ ] Set up volume persistence
- [ ] Manage environment variables
- [ ] Implement health checks
- [ ] Set up Prometheus monitoring
- [ ] Configure Grafana dashboards
- [ ] Set up Loki for logging
- [ ] Create GitHub Actions workflow
- [ ] Deploy on AWS EC2
- [ ] Compare VM vs Container deployment
- [ ] Understand migration benefits

**Congratulations! You've mastered Docker containerization! 🎉**
