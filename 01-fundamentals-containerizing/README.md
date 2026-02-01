# Class 1: Docker Fundamentals & Containerizing

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
- Docker Desktop installed
- DockerHub account created
- AWS account for ECR (optional)

### 1. Copy Files to Main Application

Copy the Dockerfiles and configurations to your main application:

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
```

---

## 🔨 Building Docker Images

### Method 1: Build Individually

**Backend:**
```powershell
# Production
cd ../backend
docker build -t bmi-backend:latest .

# Development
docker build -f Dockerfile.dev -t bmi-backend:dev .
```

**Frontend:**
```powershell
# Production
cd ../frontend
docker build -t bmi-frontend:latest .

# Development
docker build -f Dockerfile.dev -t bmi-frontend:dev .
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

## 🧪 Testing Containers Locally

### Test Backend Container

```powershell
# Run backend (will fail without database)
docker run -d `
  --name bmi-backend-test `
  -p 3000:3000 `
  -e DATABASE_URL="postgresql://bmi_user:password@host.docker.internal:5432/bmidb" `
  bmi-backend:latest

# Check logs
docker logs bmi-backend-test

# Test health endpoint
curl http://localhost:3000/health

# Stop and remove
docker stop bmi-backend-test
docker rm bmi-backend-test
```

### Test Frontend Container

```powershell
# Run frontend
docker run -d `
  --name bmi-frontend-test `
  -p 8080:80 `
  bmi-frontend:latest

# Open in browser
start http://localhost:8080

# Check logs
docker logs bmi-frontend-test

# Stop and remove
docker stop bmi-frontend-test
docker rm bmi-frontend-test
```

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

##  Useful Docker Commands

### Image Management
```powershell
# List images
docker images

# Remove image
docker rmi bmi-backend:latest

# Remove all unused images
docker image prune -a

# Inspect image
docker inspect bmi-backend:latest

# View image history (layers)
docker history bmi-backend:latest
```

### Container Management
```powershell
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>

# Remove all stopped containers
docker container prune

# Execute command in running container
docker exec -it <container-id> sh

# View container logs
docker logs <container-id>
docker logs -f <container-id>  # Follow logs
```

### Cleanup
```powershell
# Remove all stopped containers, unused networks, dangling images
docker system prune

# Remove everything including unused images
docker system prune -a

# View disk usage
docker system df
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
