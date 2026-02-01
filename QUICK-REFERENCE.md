#  Quick Reference Card - Repeatable Class Workflow

## Before Each Class

### Class 1 - Docker Fundamentals
```powershell
# Windows
cd 01-fundamentals-containerizing
.\setup.ps1
```

```bash
# Linux/Mac
cd 01-fundamentals-containerizing
./setup.sh
```

### Class 2 - Docker Compose
```powershell
# Windows
cd 02-compose-migration
.\setup.ps1
```

```bash
# Linux/Mac
cd 02-compose-migration
./setup.sh
```

---

## After Each Class

### Class 1 Cleanup
```powershell
# Windows
cd 01-fundamentals-containerizing
.\cleanup.ps1
```

```bash
# Linux/Mac
cd 01-fundamentals-containerizing
./cleanup.sh
```

### Class 2 Cleanup
```powershell
# Windows
cd 02-compose-migration
.\cleanup.ps1
```

```bash
# Linux/Mac
cd 02-compose-migration
./cleanup.sh
```

---

## What Happens?

### Setup Scripts Copy:
- **Class 1**: Dockerfiles → backend/frontend
- **Class 2**: docker-compose.yml → root, monitoring/ → root

### Cleanup Scripts Remove:
- **Class 1**: All Docker files from backend/frontend
- **Class 2**: All compose files from root + stop containers

---

## File Locations

| When | Class Materials | Application Folders |
|------|----------------|---------------------|
| **Before setup** |  Docker files here |  No Docker files |
| **After setup** |  Still here (safe) |  Docker files copied |
| **After cleanup** |  Still here (safe) |  Cleaned up |

---

## Troubleshooting

**PowerShell execution policy error?**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

**Permission denied on Linux/Mac?**
```bash
chmod +x setup.sh cleanup.sh
```

**Files not copied?**
- Check you're in the correct directory (01-fundamentals-containerizing/ or 02-compose-migration/)
- Verify source files exist in class folders

---

## Pro Tips

 **Always cleanup after class** - Keeps repository clean for Git  
 **Test before teaching** - Run setup → test builds → cleanup  
 **Commit class materials** - Never commit copied files  
 **Use both classes** - Run both setups for full-stack testing  

---

For detailed documentation, see [SETUP-GUIDE.md](SETUP-GUIDE.md)
