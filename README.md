# Docker Classes - BMI Health Tracker Application

Complete Docker training materials for containerizing and deploying a 3-tier BMI Health Tracker application.

> ** For Instructors**: See [SETUP-GUIDE.md](SETUP-GUIDE.md) for repeatable class setup/cleanup workflow.

##  Course Overview

This repository contains materials for two comprehensive Docker classes:

1. **Class 1**: Docker Fundamentals & Containerizing
2. **Class 2**: Docker Compose & Migrating Deployment from VMs to Containers

---

##  Class Structure

### [Class 1: Docker Fundamentals & Containerizing](./01-fundamentals-containerizing/README.md)

**Duration:** 3-4 hours

**Topics:**
- Introduction to Containerization
- Docker Architecture and Components
- Docker vs Virtual Machines
- Writing Dockerfiles with Best Practices
- Multi-stage Builds for Optimization
- Building and Testing Images
- Pushing to DockerHub and AWS ECR

**Deliverables:**
- Production-ready Dockerfile for backend (Node.js/Express)
- Production-ready Dockerfile for frontend (React/Vite + Nginx)
- Development Dockerfiles with hot reload
- .dockerignore files
- Nginx configuration for reverse proxy
- Build scripts

**Prerequisites:**
- Docker Desktop installed
- Basic understanding of the 3-tier application
- DockerHub account
- AWS account (optional for ECR)

[👉 Start Class 1](./01-fundamentals-containerizing/README.md)

---

### [Class 2: Docker Compose & Migration](./02-compose-migration/README.md)

**Duration:** 3-4 hours

**Topics:**
- Docker Compose for Multi-Container Orchestration
- Docker Networks and Service Discovery
- Volume Management and Data Persistence
- Environment Variables and Secrets
- Health Checks and Dependencies
- Monitoring with Prometheus & Grafana
- Logging with Loki & Promtail
- CI/CD Integration with GitHub Actions
- Deploying on AWS EC2
- VM vs Container Comparison

**Deliverables:**
- docker-compose.yml for production 3-tier stack
- docker-compose.dev.yml for development
- docker-compose.monitoring.yml for observability
- Prometheus, Loki, and Grafana configurations
- Helper scripts for easy deployment
- GitHub Actions CI/CD workflow

**Prerequisites:**
- Class 1 completed
- Understanding of Docker images and containers
- Basic knowledge of YAML syntax

[👉 Start Class 2](./02-compose-migration/README.md)

---

##  Application Architecture

### 3-Tier BMI Health Tracker

```
┌─────────────────────────────────────────────────────────┐
│                     Frontend (React)                    │
│                    Vite + Chart.js                      │
│                    Port: 80 (Nginx)                     │
└──────────────────────┬──────────────────────────────────┘
                       │ HTTP/REST API
┌──────────────────────▼──────────────────────────────────┐
│                  Backend (Node.js)                      │
│                  Express + pg driver                    │
│                     Port: 3000                          │
└──────────────────────┬──────────────────────────────────┘
                       │ PostgreSQL Protocol
┌──────────────────────▼──────────────────────────────────┐
│                Database (PostgreSQL)                    │
│                PostgreSQL 14-alpine                     │
│                     Port: 5432                          │
└─────────────────────────────────────────────────────────┘
```

**Application Features:**
- BMI (Body Mass Index) calculation
- BMR (Basal Metabolic Rate) calculation
- Daily calorie needs calculation
- Historical tracking with 30-day trends
- Interactive charts and visualizations

---

##  Repository Structure

```
docker/
├── README.md                          # This file
├── backend/                           # Original backend source code
│   ├── src/
│   ├── migrations/
│   └── package.json
├── frontend/                          # Original frontend source code
│   ├── src/
│   └── package.json
├── database/                          # Database setup scripts
│   └── setup-database.sh
├── 01-fundamentals-containerizing/    # Class 1: Docker Fundamentals
│   ├── README.md                      # Detailed Class 1 instructions
│   ├── backend/
│   │   ├── Dockerfile                 # Production multi-stage build
│   │   ├── Dockerfile.dev             # Development with nodemon
│   │   ├── .dockerignore              # Ignore patterns
│   │   └── db.js                      # Updated with retry logic
│   ├── frontend/
│   │   ├── Dockerfile                 # Multi-stage: Node + Nginx
│   │   ├── Dockerfile.dev             # Development with Vite HMR
│   │   ├── .dockerignore              # Ignore patterns
│   │   └── nginx.conf                 # Nginx reverse proxy config
│   └── scripts/
│       ├── build-all.sh               # Build all images (Linux/Mac)
│       └── build-all.ps1              # Build all images (Windows)
└── 02-compose-migration/              # Class 2: Docker Compose
    ├── README.md                      # Detailed Class 2 instructions
    ├── docker-compose.yml             # Production 3-tier stack
    ├── docker-compose.dev.yml         # Development with hot reload
    ├── docker-compose.monitoring.yml  # Observability stack
    ├── .env.example                   # Environment template
    ├── .env                           # Environment variables
    ├── .gitignore                     # Git ignore patterns
    ├── monitoring/
    │   ├── prometheus.yml             # Metrics scraping config
    │   ├── loki-config.yml            # Log storage config
    │   ├── promtail-config.yml        # Log collection config
    │   └── grafana/
    │       ├── datasources.yml        # Prometheus & Loki datasources
    │       └── dashboards/
    │           ├── dashboard.yml      # Dashboard provisioning
    │           └── bmi-app-dashboard.json
    └── scripts/
        ├── dev-up.ps1                 # Start development
        ├── prod-up.ps1                # Start production + monitoring
        ├── stop-all.ps1               # Stop all services
        ├── dev-up.sh                  # Linux/Mac versions
        └── prod-up.sh
```

---

##  Quick Start Guide

### For Instructors

#### Preparing for Class 1

1. Ensure Docker Desktop is installed on teaching machine
2. Review [01-fundamentals-containerizing/README.md](./01-fundamentals-containerizing/README.md)
3. Have DockerHub account ready
4. Prepare AWS account for ECR demo (optional)
5. Test build scripts on your system

**Key Demo Points:**
- Show Dockerfile layer caching
- Compare image sizes with/without .dockerignore
- Demonstrate multi-stage build optimization
- Live push to DockerHub

#### Preparing for Class 2

1. Complete Class 1 setup (Dockerfiles in place)
2. Review [02-compose-migration/README.md](./02-compose-migration/README.md)
3. Test docker-compose stacks
4. Prepare Grafana dashboards for demo
5. Set up GitHub repository for CI/CD demo

**Key Demo Points:**
- Show service dependencies with health checks
- Demonstrate volume persistence (stop/start with data intact)
- Live monitoring in Grafana
- Query logs in Loki
- Run GitHub Actions workflow

### For Students

#### Before Class 1

- [ ] Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [ ] Create [DockerHub account](https://hub.docker.com/)
- [ ] Verify Docker works: `docker --version`
- [ ] Clone this repository
- [ ] Review application structure

#### Before Class 2

- [ ] Complete Class 1 exercises
- [ ] Copy Dockerfiles from 01-fundamentals-containerizing to backend/frontend
- [ ] Ensure Docker Desktop has sufficient resources (4GB RAM minimum)
- [ ] Read [Docker Compose basics](https://docs.docker.com/compose/)

---

##  Learning Outcomes

After completing both classes, students will be able to:

### Technical Skills
-  Write production-ready Dockerfiles
-  Implement multi-stage builds for optimization
-  Create docker-compose configurations for multi-tier applications
-  Manage Docker networks and volumes
-  Implement health checks and container monitoring
-  Set up comprehensive observability (metrics, logs, traces)
-  Integrate Docker builds into CI/CD pipelines
-  Deploy containerized applications to cloud platforms

### Conceptual Understanding
-  Understand containerization benefits over VMs
-  Explain Docker architecture and components
-  Design microservices-ready architectures
-  Implement infrastructure as code practices
-  Apply DevOps best practices

---

## 💻 System Requirements

### Minimum
- **OS:** Windows 10/11 Pro, macOS 10.15+, or Linux
- **RAM:** 8 GB
- **Disk:** 20 GB free space
- **CPU:** 64-bit processor with virtualization support

### Recommended
- **RAM:** 16 GB
- **Disk:** 50 GB SSD
- **CPU:** Multi-core processor

### Software
- Docker Desktop 4.x or later
- Git 2.x or later
- Code editor (VS Code recommended)
- PowerShell 7+ (Windows) or Bash (Linux/Mac)

---

## 🔧 Installation & Setup

### Windows

```powershell
# Install Docker Desktop
# Download from: https://www.docker.com/products/docker-desktop/

# Verify installation
docker --version
docker-compose --version

# Clone repository
git clone https://github.com/yourusername/bmi-docker-training.git
cd bmi-docker-training
```

### macOS

```bash
# Install Docker Desktop
# Download from: https://www.docker.com/products/docker-desktop/

# Verify installation
docker --version
docker-compose --version

# Clone repository
git clone https://github.com/yourusername/bmi-docker-training.git
cd bmi-docker-training
```

### Linux

```bash
# Install Docker Engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version

# Clone repository
git clone https://github.com/yourusername/bmi-docker-training.git
cd bmi-docker-training
```

---

##  Additional Resources

### Official Documentation
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker Security](https://docs.docker.com/engine/security/)

### Learning Resources
- [Docker Getting Started Tutorial](https://docs.docker.com/get-started/)
- [Play with Docker](https://labs.play-with-docker.com/) - Free online playground
- [Docker Hub](https://hub.docker.com/) - Public image registry
- [Awesome Docker](https://github.com/veggiemonk/awesome-docker) - Curated list of resources

### Monitoring & Observability
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Tutorials](https://grafana.com/tutorials/)
- [Loki Documentation](https://grafana.com/docs/loki/latest/)

### CI/CD Integration
- [GitHub Actions for Docker](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images)
- [GitLab CI/CD with Docker](https://docs.gitlab.com/ee/ci/docker/)
- [Jenkins with Docker](https://www.jenkins.io/doc/book/installing/docker/)

---

## ❓ Troubleshooting

### Common Issues

**Docker Desktop won't start**
- Enable virtualization in BIOS
- Enable Hyper-V (Windows)
- Check system requirements

**Port conflicts**
- Change ports in .env file
- Stop conflicting services

**Build fails**
- Check .dockerignore
- Verify file paths
- Review build context

**Container exits immediately**
- Check logs: `docker logs <container>`
- Review Dockerfile CMD/ENTRYPOINT
- Verify environment variables

For detailed troubleshooting, see:
- [Class 1 README - Common Issues](./01-fundamentals-containerizing/README.md#common-issues-and-solutions)
- [Class 2 README - Common Issues](./02-compose-migration/README.md#common-issues-and-solutions)

---

## 🤝 Contributing

Improvements and suggestions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📧 Support

For questions or issues:
- Open an issue on GitHub
- Contact instructor during class
- Join Docker Community Slack

---

## 📄 License

This training material is provided for educational purposes.

---

## 🙏 Acknowledgments

- Application stack: React, Node.js, PostgreSQL
- Monitoring: Prometheus, Grafana, Loki
- Container platform: Docker
- Cloud provider: AWS (for deployment examples)

---

##  Pre-Class Checklist

### Students

- [ ] Docker Desktop installed and running
- [ ] DockerHub account created
- [ ] Repository cloned locally
- [ ] Code editor installed
- [ ] Basic understanding of the application
- [ ] System meets minimum requirements

### Instructors

- [ ] All demos tested on teaching machine
- [ ] DockerHub and AWS accounts ready
- [ ] Class materials reviewed
- [ ] Backup examples prepared
- [ ] Student prerequisites communicated
- [ ] Lab environment (if any) set up

---

**Ready to begin?**

👉 [Start with Class 1: Docker Fundamentals](./01-fundamentals-containerizing/README.md)

---

*Last updated: February 2026*
