#  Setup Guide for Instructors

## For Multiple/Repeatable Classes

This repository is designed for **teaching Docker** to multiple batches of students. The setup/cleanup scripts allow you to:
-  Prepare application folders before each class
-  Clean up after class for the next batch
-  Keep teaching materials intact in class folders

---

## 📂 Repository Structure

```
docker/
├── backend/                    # Original application (students work here)
├── frontend/                   # Original application (students work here)
├── database/                   # Database setup scripts
├── 01-fundamentals-containerizing/    # Class 1 materials
│   ├── backend/               # Reference Dockerfiles
│   ├── frontend/              # Reference Dockerfiles
│   ├── setup.ps1              #  Copy files to app folders
│   ├── cleanup.ps1            #  Remove files from app folders
│   ├── setup.sh               # Linux/Mac version
│   └── cleanup.sh             # Linux/Mac version
├── 02-compose-migration/      # Class 2 materials
│   ├── docker-compose.yml     # Reference compose files
│   ├── monitoring/            # Reference configs
│   ├── setup.ps1              #  Copy compose files to root
│   ├── cleanup.ps1            #  Remove compose files from root
│   ├── setup.sh               # Linux/Mac version
│   └── cleanup.sh             # Linux/Mac version
```

---

##  Workflow for Each Class

### Class 1: Docker Fundamentals & Containerizing

#### Before Class
**Windows:**
```powershell
cd 01-fundamentals-containerizing
.\setup.ps1
```

**Linux/Mac:**
```bash
cd 01-fundamentals-containerizing
chmod +x setup.sh
./setup.sh
```

**What it does:**
- Copies `Dockerfile`, `Dockerfile.dev`, `.dockerignore` to `backend/` and `frontend/`
- Copies `nginx.conf` to `frontend/`
- Updates `backend/src/db.js` with retry logic
-  Application folders are ready for students to build images

#### Conduct Class
- Students work directly in `backend/` and `frontend/` folders
- They build Docker images, run containers, test the application
- They push images to DockerHub/ECR

#### After Class
**Windows:**
```powershell
cd 01-fundamentals-containerizing
.\cleanup.ps1
```

**Linux/Mac:**
```bash
cd 01-fundamentals-containerizing
./cleanup.sh
```

**What it does:**
- Removes all Docker files from `backend/` and `frontend/`
-  Application folders restored to original state for next class
-  Note: `db.js` is kept (it has useful retry logic)

---

### Class 2: Docker Compose & Migration

#### Before Class
**Windows:**
```powershell
cd 02-compose-migration
.\setup.ps1
```

**Linux/Mac:**
```bash
cd 02-compose-migration
chmod +x setup.sh
./setup.sh
```

**What it does:**
- Copies `docker-compose.yml` files to root directory
- Creates `monitoring/` folder with Prometheus, Grafana, Loki configs
- Copies helper scripts (`start.ps1`, `stop.ps1`, etc.)
- Copies `.env.example` template
-  Ready for full-stack orchestration

#### Conduct Class
- Students create `.env` file from `.env.example`
- They run `docker-compose up -d` to start all services
- They configure monitoring dashboards
- They test the full application stack

#### After Class
**Windows:**
```powershell
cd 02-compose-migration
.\cleanup.ps1
```

**Linux/Mac:**
```bash
cd 02-compose-migration
./cleanup.sh
```

**What it does:**
- Stops all running containers (`docker-compose down -v`)
- Removes `docker-compose.yml` files from root
- Deletes `monitoring/` folder
- Removes helper scripts
-  Root directory cleaned for next class

---

##  Key Benefits

###  For Multiple Batches
- Run setup before each class → students get clean environment
- Run cleanup after class → repository ready for next batch
- No manual file copying needed

###  Keeps Materials Safe
- Original Dockerfiles stay in `01-fundamentals-containerizing/` and `02-compose-migration/`
- Students work in `backend/` and `frontend/` folders
- Class materials never get modified accidentally

###  Git-Friendly
- After cleanup, git status shows clean working tree
- Easy to commit and push changes to teaching materials
- No messy student work polluting the repository

---

## 📝 Quick Reference

| Action | Class 1 Command | Class 2 Command |
|--------|----------------|----------------|
| **Setup** | `.\01-fundamentals-containerizing\setup.ps1` | `.\02-compose-migration\setup.ps1` |
| **Cleanup** | `.\01-fundamentals-containerizing\cleanup.ps1` | `.\02-compose-migration\cleanup.ps1` |
| **Linux Setup** | `./01-fundamentals-containerizing/setup.sh` | `./02-compose-migration/setup.sh` |
| **Linux Cleanup** | `./01-fundamentals-containerizing/cleanup.sh` | `./02-compose-migration/cleanup.sh` |

---

##  What Files Get Copied?

### Class 1 Setup
| Source | Destination |
|--------|-------------|
| `01-fundamentals-containerizing/backend/Dockerfile` | `backend/Dockerfile` |
| `01-fundamentals-containerizing/backend/Dockerfile.dev` | `backend/Dockerfile.dev` |
| `01-fundamentals-containerizing/backend/.dockerignore` | `backend/.dockerignore` |
| `01-fundamentals-containerizing/backend/db.js` | `backend/src/db.js` |
| `01-fundamentals-containerizing/frontend/Dockerfile` | `frontend/Dockerfile` |
| `01-fundamentals-containerizing/frontend/Dockerfile.dev` | `frontend/Dockerfile.dev` |
| `01-fundamentals-containerizing/frontend/.dockerignore` | `frontend/.dockerignore` |
| `01-fundamentals-containerizing/frontend/nginx.conf` | `frontend/nginx.conf` |

### Class 2 Setup
| Source | Destination |
|--------|-------------|
| `02-compose-migration/docker-compose.yml` | `docker-compose.yml` |
| `02-compose-migration/docker-compose.dev.yml` | `docker-compose.dev.yml` |
| `02-compose-migration/docker-compose.monitoring.yml` | `docker-compose.monitoring.yml` |
| `02-compose-migration/.env.example` | `.env.example` |
| `02-compose-migration/monitoring/*` | `monitoring/*` |
| `02-compose-migration/start.ps1` | `start.ps1` |
| `02-compose-migration/stop.ps1` | `stop.ps1` |
| `02-compose-migration/start.sh` | `start.sh` |
| `02-compose-migration/stop.sh` | `stop.sh` |

---

##  Tips

1. **First Time Setup**: Run Class 1 setup even if not teaching - this ensures docker-compose can find the Dockerfiles
2. **Between Classes**: Always run cleanup, commit/push changes, then run setup for next class
3. **Testing**: Run setup → test builds → run cleanup to verify scripts work
4. **Student Repos**: Students can fork the repo and run setup scripts themselves for home practice

---

##  Important Notes

- **db.js**: The cleanup script keeps `backend/src/db.js` because it has important retry logic for Docker environments. This is intentional.
- **Docker Volumes**: Class 2 cleanup runs `docker-compose down -v` which removes volumes. Warn students to back up data if needed.
- **.env File**: Not included in class materials. Students create this from `.env.example`.

---

##  One-Command Setup (All Classes)

If you want to prepare for both classes at once:

**Windows:**
```powershell
.\01-fundamentals-containerizing\setup.ps1
.\02-compose-migration\setup.ps1
```

**Linux/Mac:**
```bash
./01-fundamentals-containerizing/setup.sh
./02-compose-migration/setup.sh
```

This is useful for:
- Testing the full stack before teaching
- Recording demonstration videos
- Creating screenshots for presentations

---

## 📧 Questions?

If scripts don't work:
1. Check you're in the correct directory
2. Verify PowerShell execution policy (Windows): `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
3. Verify script permissions (Linux/Mac): `chmod +x *.sh`
4. Check paths in scripts match your folder structure
