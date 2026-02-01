# Class 1: Docker Fundamentals & Containerizing

##  Class Structure

### Part 1: Docker Basics (Hands-On Introduction)
We'll start by understanding what Docker is and how it works through simple, practical examples:
- What is Docker and why do we need it?
- Running your first container (Nginx)
- Basic Docker commands
- Understanding images vs containers

### Part 2: Real-World Application (Three-Tier BMI Tracker)
After mastering the basics, we'll containerize a complete three-tier application:
- Containerizing a PostgreSQL database
- Containerizing a Node.js/Express backend
- Containerizing a React/Vite frontend with Nginx
- Making all three containers work together

---

##  Part 1: Docker Basics - Let's Get Started! 🚀

### What is Docker?

**Docker** is a platform that allows you to package your application and all its dependencies into a **container** - a lightweight, standalone, executable package that runs the same way everywhere.

**Key Concepts:**
- **Image**: A blueprint/template (like a recipe)
- **Container**: A running instance of an image (like a cake made from the recipe)
- **Docker Hub**: A registry where Docker images are stored (like GitHub for Docker images)

**Why Docker?**
- ✅ "It works on my machine" → Now it works everywhere!
- ✅ Lightweight compared to Virtual Machines
- ✅ Fast startup (seconds vs minutes)
- ✅ Easy to share and deploy
- ✅ Isolated environments

---

### 🎯 Your First Docker Container - Nginx Web Server

Let's run a real web server in seconds!

#### Step 1: Pull Nginx Image

```powershell
# Download the nginx image from Docker Hub
docker pull nginx:alpine
```

**What happens:**
- Docker downloads the `nginx:alpine` image (a lightweight Linux with Nginx pre-installed)
- The image is stored locally on your machine

**Verify the image:**
```powershell
docker images
```

You should see something like:
```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
nginx        alpine    a64a6e03b055   2 weeks ago    43.3MB
```

---

#### Step 2: Run Nginx Container

```powershell
# Run nginx container in detached mode (-d) with port mapping
docker run -d --name my-nginx -p 80:80 nginx:alpine
```

**Understanding the command:**
- `docker run` - Create and start a container
- `-d` - Detached mode (runs in background)
- `--name my-nginx` - Give it a friendly name
- `-p 80:80` - Map port 80 on your computer to port 80 in the container
- `nginx:alpine` - The image to use

---

#### Step 3: See It Running!

**Open your browser and go to:**
```
http://localhost:80
```

You should see the **"Welcome to nginx!"** page. 🎉

**Or test from PowerShell:**
```powershell
Invoke-WebRequest -Uri http://localhost:80 -UseBasicParsing | Select-Object StatusCode, StatusDescription
```

You should see:
```
StatusCode StatusDescription
---------- -----------------
       200 OK
```

---

#### Step 4: Explore Your Container

```powershell
# List running containers
docker ps

# View nginx logs
docker logs my-nginx

# See real-time logs
docker logs -f my-nginx

# Check container details
docker inspect my-nginx

# See resource usage
docker stats my-nginx

# Execute commands inside the container
docker exec -it my-nginx sh

# Once inside, you can explore:
ls -la /usr/share/nginx/html/
cat /usr/share/nginx/html/index.html
exit
```

---

#### Step 5: Modify Content (Optional)

Let's change what nginx serves!

```powershell
# Create a custom HTML file
echo '<h1>Hello from Docker! 🐳</h1>' > index.html

# Copy it into the running container
docker cp index.html my-nginx:/usr/share/nginx/html/index.html

# Refresh your browser - see the change!
```

---

#### Step 6: Container Lifecycle

```powershell
# Stop the container
docker stop my-nginx

# Verify it's stopped (check STATUS column)
docker ps -a

# Start it again
docker start my-nginx

# Restart (stop + start)
docker restart my-nginx

# View logs from stopped container
docker logs my-nginx
```

---

#### Step 7: Cleanup

```powershell
# Stop the container
docker stop my-nginx

# Remove the container
docker rm my-nginx

# Remove the image (optional)
docker rmi nginx:alpine

# Verify everything is cleaned up
docker ps -a
docker images
```

---

### 🧠 What Did We Learn?

1. **Docker Images** are templates stored locally
2. **Docker Containers** are running instances of images
3. **Port Mapping** (`-p 80:80`) connects your computer to the container
4. **Containers are isolated** - the nginx runs in its own environment
5. **Containers are fast** - started in seconds!
6. **Easy cleanup** - remove containers and images without affecting your system

---

### 🎓 Key Docker Commands Recap

| Command | Purpose |
|---------|---------|
| `docker pull <image>` | Download an image from Docker Hub |
| `docker images` | List all images on your machine |
| `docker run -d -p <host>:<container> <image>` | Run a container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (running + stopped) |
| `docker logs <container>` | View container logs |
| `docker exec -it <container> sh` | Enter container shell |
| `docker stop <container>` | Stop a running container |
| `docker start <container>` | Start a stopped container |
| `docker rm <container>` | Remove a container |
| `docker rmi <image>` | Remove an image |

---

##  Part 2: Real-World Application - BMI Tracker

Now that you understand Docker basics, let's apply this knowledge to containerize a **real three-tier application**!

### What You'll Build

By the end of this part, you will have **3 running Docker containers** working together:

1. **Database Container** (postgres:15-alpine)
   - PostgreSQL database
   - User: `bmi_user`, Database: `bmidb`
   - Tables created via migration scripts
   - Port: 5432

2. **Backend Container** (bmi-backend:latest)
   - Node.js/Express API
   - Connects to database
   - Health checks enabled
   - Port: 3000

3. **Frontend Container** (bmi-frontend:latest)
   - React/Vite application
   - Served by Nginx
   - Reverse proxy to backend
   - Port: 8080

---

##  Learning Objectives

By the end of this class, students will:
- Understand containerization concepts and Docker architecture
- Write Dockerfiles following best practices
- Build and manage Docker images
- Run and test containers locally
- Push images to DockerHub and AWS ECR

---

##  Topics Covered

1. **Introduction to Containerization**
   - Why move from VMs to Containers?
   - Docker vs Virtual Machines
   - Benefits for our Three-Tier Application

2. **Docker Fundamentals**
   - Docker Images vs Containers
   - Docker Architecture (Client-Server, Docker Daemon)
   - Docker Registry (DockerHub, AWS ECR)

3. **Dockerfile Best Practices**
   - Multi-stage builds for optimization
   - Layer caching
   - .dockerignore files
   - Security considerations (non-root user)

4. **Containerizing Backend (Node.js/Express)**
   - Analyzing dependencies
   - Creating production Dockerfile
   - Creating development Dockerfile
   - Database connection handling in Docker

5. **Containerizing Frontend (React/Vite)**
   - Multi-stage build (build + runtime)
   - Using Nginx for production
   - Configuring Nginx as reverse proxy

6. **Building and Testing**
   - Building images locally
   - Running containers manually
   - Testing health checks
   - Viewing logs and debugging

7. **Image Registry**
   - Pushing to DockerHub
   - AWS ECR setup and authentication
   - Tagging strategies

---

##  Files Overview

### Backend Files
```
backend/
├── Dockerfile          # Production multi-stage build
├── Dockerfile.dev      # Development with hot reload
├── .dockerignore       # Ignore node_modules, logs, etc.
└── db.js              # Updated with retry logic for Docker
```

### Frontend Files
```
frontend/
├── Dockerfile          # Multi-stage: Build with Node + Serve with Nginx
├── Dockerfile.dev      # Development with Vite dev server
├── .dockerignore       # Ignore node_modules, dist, etc.
└── nginx.conf         # Nginx configuration for SPA + API proxy
```

### Scripts
```
scripts/
├── build-all.sh       # Build all images (Linux/Mac)
└── build-all.ps1      # Build all images (Windows PowerShell)
```

---

##  Getting Started

### Prerequisites
- Docker Desktop installed and running
- DockerHub account created (optional - for pushing images)
- AWS account for ECR (optional)

### Step 0: Start PostgreSQL Database Container

Since we're working with Docker, start the database in a container first:

```powershell
# Start PostgreSQL in Docker
docker run -d `
  --name postgres-bmi `
  -e POSTGRES_USER=bmi_user `
  -e POSTGRES_PASSWORD=strongpassword `
  -e POSTGRES_DB=bmidb `
  -p 5432:5432 `
  postgres:15-alpine

# Wait for database to initialize
Start-Sleep -Seconds 5

# Verify database is running
docker ps | Select-String "postgres-bmi"

# Run migrations (from 01-fundamentals-containerizing directory)
Get-Content ..\backend\migrations\001_create_measurements.sql | docker exec -i postgres-bmi psql -U bmi_user -d bmidb
Get-Content ..\backend\migrations\002_add_measurement_date.sql | docker exec -i postgres-bmi psql -U bmi_user -d bmidb

# Verify tables were created
docker exec postgres-bmi psql -U bmi_user -d bmidb -c "\dt"
```

**Expected output:**
```
           List of relations
 Schema |     Name      | Type  |  Owner
--------+---------------+-------+----------
 public | measurements  | table | bmi_user
```

**Note:** This database container will run throughout the class. Class 2 covers proper multi-container orchestration with Docker Compose.

### Step 1: Run Setup Script

The setup script will copy all Docker files to your application folders:

```powershell
# From 01-fundamentals-containerizing directory
.\setup.ps1
```

This will copy:
- Backend: Dockerfile, Dockerfile.dev, .dockerignore, db.js, .env
- Frontend: Dockerfile, Dockerfile.dev, .dockerignore, nginx.conf

**Manual Alternative** (if you prefer to see each step):

```powershell
# Copy backend files
Copy-Item .\backend\Dockerfile ..\..\backend\
Copy-Item .\backend\Dockerfile.dev ..\..\backend\
Copy-Item .\backend\.dockerignore ..\..\backend\

# Copy frontend files
Copy-Item .\frontend\Dockerfile ..\..\frontend\
Copy-Item .\frontend\Dockerfile.dev ..\..\frontend\
Copy-Item .\frontend\.dockerignore ..\..\frontend\
Copy-Item .\frontend\nginx.conf ..\..\frontend\

# Update backend db.js with retry logic
Copy-Item .\backend\db.js ..\..\backend\src\db.js

# Copy .env file
Copy-Item .\backend\.env.example ..\..\backend\.env
```

### Step 2: Verify Environment Configuration

Check that the `.env` file has correct database credentials:

```powershell
# View .env file
Get-Content ..\backend\.env
```

Should contain:
```
PORT=3000
DATABASE_URL=postgresql://bmi_user:strongpassword@localhost:5432/bmidb
NODE_ENV=production
FRONTEND_URL=http://localhost
```

---

## 🔨 Step 3: Building Docker Images

### Generate Package Lock Files

Before building, install dependencies to generate package-lock.json files:

```powershell
# Install dependencies to generate package-lock.json for both projects
cd ../backend
npm install
cd ../frontend
npm install
cd ../01-fundamentals-containerizing
```

### Method 1: Build Individually

```powershell
# Build Backend - Production
cd ../backend
docker build -t bmi-backend:latest .

# Build Backend - Development
docker build -f Dockerfile.dev -t bmi-backend:dev .

# Build Frontend - Production
cd ../frontend
docker build -t bmi-frontend:latest .

# Build Frontend - Development
docker build -f Dockerfile.dev -t bmi-frontend:dev .

# Return to class directory
cd ../01-fundamentals-containerizing
```

### Method 2: Build All at Once

```powershell
# From 01-fundamentals-containerizing directory
cd scripts
.\build-all.ps1
```

### View Built Images
```powershell
docker images | Select-String "bmi"
```

---

## 🧪 Step 4: Testing Containers Locally

### Test Backend Container

Now that the database is running, test the backend container:

```powershell
# Verify database is running first
docker ps | Select-String "postgres-bmi"

# Run backend container
docker run -d `
  --name bmi-backend-test `
  -p 3000:3000 `
  -e DATABASE_URL="postgresql://bmi_user:strongpassword@host.docker.internal:5432/bmidb" `
  bmi-backend:latest

# Wait a moment for backend to start
Start-Sleep -Seconds 3

# Check logs - should show successful database connection
docker logs bmi-backend-test

# Test health endpoint
Invoke-WebRequest -Uri http://localhost:3000/health -UseBasicParsing

# Test API endpoint
Invoke-WebRequest -Uri http://localhost:3000/api/measurements -UseBasicParsing

# Stop and remove when done testing
docker stop bmi-backend-test
docker rm bmi-backend-test
```

**Expected responses:**
- Health endpoint: `{"status":"ok","environment":"development"}`
- API endpoint: `{"rows":[]}` (empty array - no data yet)

**Expected logs:**
```
Server running on port 3000
📊 Environment: development
🔗 API available at: http://localhost:3000/api
✅ Database connected successfully at [timestamp]
```

**Note:** If you see retry attempts in the logs, it means the backend tried to connect before the database was fully ready. The retry logic will automatically reconnect. You should eventually see "Database connected successfully".

### Test Frontend Container

```powershell
# Make sure backend is running first
docker ps | Select-String "bmi-backend-test"

# Run frontend
docker run -d `
  --name bmi-frontend-test `
  -p 8080:80 `
  bmi-frontend:latest

# Wait a moment for nginx to start
Start-Sleep -Seconds 2

# Check logs
docker logs bmi-frontend-test

# Open in browser
start http://localhost:8080

# Stop and remove when done testing
docker stop bmi-frontend-test
docker rm bmi-frontend-test
```

**Expected logs:**
```
Configuration complete; ready for start up
```

**Note:** The frontend nginx is configured to proxy `/api` requests to `host.docker.internal:3000` (the backend container). This works for Class 1. In Class 2, we'll use Docker Compose networking where containers can reference each other by name.

### Verify All 3 Containers Running

Check that all containers are up and running:

```powershell
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
```

**Expected output:**
```
NAMES               IMAGE                  PORTS                    STATUS
bmi-frontend-test   bmi-frontend:latest    0.0.0.0:8080->80/tcp    Up X seconds
bmi-backend-test    bmi-backend:latest     0.0.0.0:3000->3000/tcp  Up X seconds  
postgres-bmi        postgres:15-alpine     0.0.0.0:5432->5432/tcp  Up X minutes
```

**Full Stack Test:**
1. Open browser: http://localhost:8080 (Frontend)
2. Frontend calls: http://localhost:8080/api (Backend via Nginx proxy)
3. Backend queries: postgres-bmi database on port 5432

### Cleanup After Testing

```powershell
# Complete cleanup (recommended at end of class)
# This will stop containers, remove them, and delete built images
.\cleanup.ps1

# Or manually stop and remove containers
docker stop bmi-backend-test bmi-frontend-test postgres-bmi
docker rm bmi-backend-test bmi-frontend-test postgres-bmi

# Remove built images
docker rmi bmi-backend:latest bmi-backend:dev bmi-frontend:latest bmi-frontend:dev

# Or keep database running for further testing
docker stop bmi-backend-test bmi-frontend-test
docker rm bmi-backend-test bmi-frontend-test
```

**Note:** The cleanup script (`cleanup.ps1` or `cleanup.sh`) will:
- Stop and remove all Docker containers (postgres-bmi, bmi-backend-test, bmi-frontend-test)
- Remove all locally built images (bmi-backend:latest, bmi-backend:dev, bmi-frontend:latest, bmi-frontend:dev)
- Remove Docker files from backend and frontend folders
- Preserve db.js improvements

---

## 📤 Pushing to DockerHub

### 1. Login to DockerHub
```powershell
docker login
# Enter username and password
```

### 2. Tag Images
```powershell
# Replace 'yourusername' with your DockerHub username
docker tag bmi-backend:latest yourusername/bmi-backend:latest
docker tag bmi-frontend:latest yourusername/bmi-frontend:latest

# Tag with version
docker tag bmi-backend:latest yourusername/bmi-backend:v1.0.0
docker tag bmi-frontend:latest yourusername/bmi-frontend:v1.0.0
```

### 3. Push Images
```powershell
docker push yourusername/bmi-backend:latest
docker push yourusername/bmi-backend:v1.0.0
docker push yourusername/bmi-frontend:latest
docker push yourusername/bmi-frontend:v1.0.0
```

---

##  Pushing to AWS ECR

### 1. Create ECR Repositories
```powershell
aws ecr create-repository --repository-name bmi-backend --region us-east-1
aws ecr create-repository --repository-name bmi-frontend --region us-east-1
```

### 2. Authenticate Docker to ECR
```powershell
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```

### 3. Tag Images for ECR
```powershell
# Replace with your AWS account ID and region
$AWS_ACCOUNT_ID = "123456789012"
$AWS_REGION = "us-east-1"
$ECR_REGISTRY = "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

docker tag bmi-backend:latest $ECR_REGISTRY/bmi-backend:latest
docker tag bmi-frontend:latest $ECR_REGISTRY/bmi-frontend:latest
```

### 4. Push to ECR
```powershell
docker push $ECR_REGISTRY/bmi-backend:latest
docker push $ECR_REGISTRY/bmi-frontend:latest
```

---

##  Essential Docker Commands Reference

This section covers all the Docker commands you'll use in this class with practical examples.

---

### 🐳 Container Lifecycle Commands

#### Starting Containers

```powershell
# Run a container in detached mode (-d)
docker run -d --name postgres-bmi -p 5432:5432 postgres:15-alpine

# Run with environment variables
docker run -d `
  --name bmi-backend-test `
  -p 3000:3000 `
  -e DATABASE_URL="postgresql://user:pass@host:5432/db" `
  bmi-backend:latest

# Run interactively (for debugging)
docker run -it --name test-container bmi-backend:latest sh
```

#### Stopping & Starting

```powershell
# Stop a running container
docker stop bmi-backend-test

# Stop multiple containers
docker stop bmi-backend-test bmi-frontend-test postgres-bmi

# Stop all running containers
docker stop $(docker ps -q)

# Start a stopped container
docker start bmi-backend-test

# Restart a container
docker restart bmi-backend-test

# Restart with timeout (seconds)
docker restart -t 10 bmi-backend-test
```

#### Removing Containers

```powershell
# Remove a stopped container
docker rm bmi-backend-test

# Force remove a running container
docker rm -f bmi-backend-test

# Remove multiple containers
docker rm bmi-backend-test bmi-frontend-test

# Remove all stopped containers
docker container prune

# Remove all containers (stopped and running)
docker rm -f $(docker ps -aq)
```

---

### 📋 Viewing Container Information

#### List Containers

```powershell
# List running containers
docker ps

# List all containers (running + stopped)
docker ps -a

# Custom format output
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

# Filter by name
docker ps -a --filter "name=bmi"

# Filter by status
docker ps --filter "status=running"
docker ps --filter "status=exited"

# Show only container IDs
docker ps -q

# Show last created container
docker ps -l
```

#### Container Details

```powershell
# View detailed container info
docker inspect bmi-backend-test

# Get specific info (IP address)
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bmi-backend-test

# Get container's environment variables
docker inspect -f '{{.Config.Env}}' bmi-backend-test

# Check container resource usage
docker stats bmi-backend-test

# Real-time stats for all containers
docker stats

# Show container processes
docker top bmi-backend-test
```

---

### 📝 Logs & Debugging

#### Viewing Logs

```powershell
# View logs
docker logs bmi-backend-test

# Follow logs (live)
docker logs -f bmi-backend-test

# Show last 50 lines
docker logs --tail 50 bmi-backend-test

# Show logs with timestamps
docker logs -t bmi-backend-test

# Show logs since specific time
docker logs --since 5m bmi-backend-test  # Last 5 minutes
docker logs --since 2026-02-01T07:00:00 bmi-backend-test

# Combine options
docker logs -f --tail 100 -t bmi-backend-test
```

#### Executing Commands in Containers

```powershell
# Execute interactive shell
docker exec -it bmi-backend-test sh

# Execute command and exit
docker exec bmi-backend-test ls -la /app

# Execute as root user
docker exec -u root -it bmi-backend-test sh

# Execute in working directory
docker exec -w /app bmi-backend-test pwd

# Run database commands
docker exec postgres-bmi psql -U bmi_user -d bmidb -c "SELECT * FROM measurements;"

# Copy file into container
docker cp local-file.txt bmi-backend-test:/app/

# Copy file from container
docker cp bmi-backend-test:/app/logs/app.log ./

# View container filesystem changes
docker diff bmi-backend-test
```

---

### 🖼️ Image Management

#### Building Images

```powershell
# Build from Dockerfile
docker build -t bmi-backend:latest .

# Build with custom Dockerfile
docker build -f Dockerfile.dev -t bmi-backend:dev .

# Build without cache (force rebuild)
docker build --no-cache -t bmi-backend:latest .

# Build with build arguments
docker build --build-arg NODE_VERSION=18 -t bmi-backend:latest .

# Tag during build
docker build -t myuser/bmi-backend:v1.0.0 -t myuser/bmi-backend:latest .
```

#### Listing Images

```powershell
# List all images
docker images

# List images with filter
docker images | Select-String "bmi"

# Show image IDs only
docker images -q

# Show dangling images (untagged)
docker images -f "dangling=true"

# Show images with size
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
```

#### Tagging Images

```powershell
# Tag an image
docker tag bmi-backend:latest myuser/bmi-backend:latest

# Tag with version
docker tag bmi-backend:latest myuser/bmi-backend:v1.0.0

# Re-tag existing image
docker tag bmi-backend:latest bmi-backend:backup
```

#### Inspecting Images

```powershell
# View image details
docker inspect bmi-backend:latest

# View image layers and size
docker history bmi-backend:latest

# View detailed layer info
docker history --no-trunc bmi-backend:latest

# Check image size only
docker images bmi-backend:latest --format "{{.Size}}"
```

#### Removing Images

```powershell
# Remove single image
docker rmi bmi-backend:latest

# Remove multiple images
docker rmi bmi-backend:latest bmi-frontend:latest

# Force remove (even if containers exist)
docker rmi -f bmi-backend:latest

# Remove all unused images
docker image prune

# Remove all images
docker image prune -a

# Remove dangling images only
docker image prune -f
```

---

### 🔍 Registry Operations

#### Docker Hub

```powershell
# Login to Docker Hub
docker login

# Login with username
docker login -u myusername

# Pull image
docker pull nginx:alpine

# Push image
docker push myuser/bmi-backend:latest

# Logout
docker logout
```

#### AWS ECR

```powershell
# Authenticate to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com

# Create repository
aws ecr create-repository --repository-name bmi-backend --region us-east-1

# Tag for ECR
docker tag bmi-backend:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/bmi-backend:latest

# Push to ECR
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/bmi-backend:latest
```

---

### 🌐 Networking

```powershell
# List networks
docker network ls

# Inspect network
docker network inspect bridge

# Create custom network
docker network create bmi-network

# Connect container to network
docker network connect bmi-network bmi-backend-test

# Disconnect from network
docker network disconnect bmi-network bmi-backend-test

# Remove network
docker network rm bmi-network

# Run container on specific network
docker run -d --name backend --network bmi-network bmi-backend:latest
```

---

### 💾 Volume Management

```powershell
# List volumes
docker volume ls

# Create volume
docker volume create postgres-data

# Inspect volume
docker volume inspect postgres-data

# Remove volume
docker volume rm postgres-data

# Remove all unused volumes
docker volume prune

# Run container with volume
docker run -d -v postgres-data:/var/lib/postgresql/data postgres:15-alpine

# Bind mount (host directory)
docker run -d -v C:\app\data:/app/data bmi-backend:latest
```

---

### 🧹 System Cleanup

```powershell
# Remove stopped containers
docker container prune

# Remove unused images
docker image prune

# Remove unused volumes
docker volume prune

# Remove unused networks
docker network prune

# Remove everything unused (containers, images, networks, volumes)
docker system prune -a --volumes

# View disk usage
docker system df

# Detailed disk usage
docker system df -v
```

---

### 🎯 Useful Combinations

#### Complete Container Restart

```powershell
# Stop, remove, rebuild, and run
docker stop bmi-backend-test
docker rm bmi-backend-test
docker build -t bmi-backend:latest .
docker run -d --name bmi-backend-test -p 3000:3000 bmi-backend:latest
```

#### Quick Cleanup & Rebuild

```powershell
# Remove container and image, rebuild fresh
docker rm -f bmi-backend-test
docker rmi bmi-backend:latest
docker build --no-cache -t bmi-backend:latest .
docker run -d --name bmi-backend-test -p 3000:3000 bmi-backend:latest
```

#### Debug Container Issues

```powershell
# Check logs, inspect, and enter container
docker logs bmi-backend-test
docker inspect bmi-backend-test
docker exec -it bmi-backend-test sh
```

#### Monitor All Containers

```powershell
# Watch container stats in real-time
docker stats

# List all with detailed info
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Check resource usage
docker system df
```

---

### 📊 Health Checks

```powershell
# Check container health status
docker inspect --format='{{.State.Health.Status}}' bmi-backend-test

# View health check logs
docker inspect --format='{{json .State.Health}}' bmi-backend-test

# Wait for container to be healthy
docker run -d --name backend --health-cmd="wget -q -O- http://localhost:3000/health" bmi-backend:latest
```

---

### 🔧 Advanced Operations

#### Export & Import

```powershell
# Export container as tar
docker export bmi-backend-test > backend-container.tar

# Import tar as image
docker import backend-container.tar myimage:latest

# Save image to tar
docker save bmi-backend:latest > backend-image.tar

# Load image from tar
docker load < backend-image.tar
```

#### Container State Management

```powershell
# Pause container
docker pause bmi-backend-test

# Unpause container
docker unpause bmi-backend-test

# Get container exit code
docker inspect --format='{{.State.ExitCode}}' bmi-backend-test

# Wait for container to stop
docker wait bmi-backend-test

# Attach to running container
docker attach bmi-backend-test
```

---

## 📊 Dockerfile Explanation

### Backend Dockerfile Structure

```dockerfile
# Stage 1: Install dependencies
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Runtime
FROM node:18-alpine AS runtime
WORKDIR /app

# Install wget for health checks
RUN apk add --no-cache wget

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy dependencies from previous stage
COPY --from=deps /app/node_modules ./node_modules

# Copy application code
COPY . .

# Set ownership
RUN chown -R nodejs:nodejs /app

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1

# Start application
CMD ["node", "src/server.js"]
```

**Key Points:**
- **Multi-stage build**: Separates dependency installation from runtime
- **Alpine Linux**: Smaller base image (~5MB vs ~900MB)
- **Non-root user**: Security best practice
- **Health check**: Docker can monitor container health
- **Layer caching**: package.json copied before source code

### Frontend Dockerfile Structure

```dockerfile
# Stage 1: Build application
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine AS runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Key Points:**
- **Multi-stage build**: Build stage (~400MB) vs Runtime stage (~25MB)
- **Nginx**: Production-ready web server
- **Static files**: Only dist/ copied to final image
- **Reverse proxy**: nginx.conf proxies /api to backend

---

##  Common Issues and Solutions

### 1. Build Fails - Cannot Find Package.json
**Problem:** `COPY package*.json ./` fails

**Solution:** Ensure you're building from the correct directory
```powershell
cd backend  # or frontend
docker build -t image-name .
```

### 2. Port Already in Use
**Problem:** `bind: address already in use`

**Solution:** Use different host port or stop conflicting container
```powershell
# Use different port
docker run -p 3001:3000 image-name

# Find and stop conflicting container
docker ps
docker stop <container-id>
```

### 3. Image Size Too Large
**Problem:** Image is several GBs

**Solution:** Check .dockerignore file includes:
```
node_modules
dist
.git
```

### 4. Container Exits Immediately
**Problem:** Container stops right after starting

**Solution:** Check logs for errors
```powershell
docker logs <container-id>
```

### 5. Cannot Connect to Database
**Problem:** Backend cannot connect to PostgreSQL

**Solution:** Use correct host:
- From container to host: `host.docker.internal`
- Between containers: Use container name or Docker network

### 6. Frontend Container Exits with nginx Error
**Problem:** `nginx: [emerg] host not found in upstream "backend"`

**Solution:** The nginx.conf needs to use `host.docker.internal:3000` instead of `backend:3000` for Class 1. If you see this error:
```powershell
# Stop and remove the container
docker stop bmi-frontend-test
docker rm bmi-frontend-test

# Rebuild without cache to ensure nginx.conf changes are picked up
cd ../frontend
docker build --no-cache -t bmi-frontend:latest .

# Run the container again
docker run -d --name bmi-frontend-test -p 8080:80 bmi-frontend:latest
```

### 7. Build Fails - npm ci Requires package-lock.json
**Problem:** `npm ci` command fails during build

**Solution:** Generate package-lock.json files first:
```powershell
cd ../backend
npm install
cd ../frontend
npm install
```

### 8. Backend Shows Retry Attempts in Logs
**Problem:** Backend logs show database connection retries

**Solution:** This is normal if backend starts before database is fully ready. The retry logic will automatically connect. Wait a few seconds and check logs again - you should see "Database connected successfully".

---

##  Class Activities

### Activity 1: Build Your First Image
1. Navigate to backend directory
2. Build the image
3. Check image size
4. View image layers with `docker history`

### Activity 2: Compare Development vs Production
1. Build both Dockerfile and Dockerfile.dev
2. Compare image sizes
3. Run both and observe behavior

### Activity 3: Optimize Image Size
1. Build without .dockerignore
2. Build with .dockerignore
3. Compare sizes

### Activity 4: Multi-stage Build Benefits
1. Build frontend image
2. Check size of final image
3. Compare with single-stage build

### Activity 5: Push to Registry
1. Tag your images
2. Push to DockerHub
3. Pull on another machine or delete local and pull

---

## 📝 Homework

1. **Add Build Arguments**
   - Modify Dockerfile to accept NODE_VERSION as build arg
   - Build with different Node versions

2. **Create Custom Health Checks**
   - Add more sophisticated health checks
   - Test failure scenarios

3. **Optimize Further**
   - Research and implement additional optimizations
   - Document size improvements

4. **Document Your Build**
   - Create a build script with tagging strategy
   - Add version management

---

## 🔗 Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker Hub](https://hub.docker.com/)
- [AWS ECR Documentation](https://docs.aws.amazon.com/ecr/)
- [Node.js Docker Best Practices](https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md)

---

##  Class 1 Checklist

- [ ] Understand containerization concepts
- [ ] Install Docker Desktop
- [ ] Write Dockerfile for backend
- [ ] Write Dockerfile for frontend
- [ ] Implement multi-stage builds
- [ ] Create .dockerignore files
- [ ] Build images successfully
- [ ] Test containers locally
- [ ] Push images to DockerHub
- [ ] Push images to AWS ECR (optional)
- [ ] Understand layer caching
- [ ] Implement health checks

**Ready for Class 2!** 🎉
