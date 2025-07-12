# 🔗 Submodule Management Guide

This guide explains how to work with Git submodules in the Federated Learning project.

## 📋 **Current Submodules**

```
🗂️ TFM-Federated-learning-on-edge-nodes/
├── 🔧 fl-common/                     # Shared components
│   └── 📦 Repository: adrianoggm/fl-common
├── 🌫️ fl-fog/                        # Fog computing layer
│   └── 📦 Repository: adrianoggm/fl-fog
├── 📱 fl-client/                     # Edge device agent
│   └── 📦 Repository: adrianoggm/fl-client
├── 🖥️ fl-server/                     # Cloud server
│   └── 📦 Repository: adrianoggm/fl-server
└── 🤖 fl-ml-models/                  # ML model implementations
    └── 📦 Repository: adrianoggm/fl-ml-models
```

## 🚀 **Quick Start**

### **First Time Setup (New Clone)**

```bash
# Clone repository with all submodules
git clone --recursive https://github.com/adrianoggm/TFM-Federated-learning-on-edge-nodes.git

# OR use the management script
./submodule-manager.sh clone https://github.com/adrianoggm/TFM-Federated-learning-on-edge-nodes.git
```

### **If You Already Cloned Without --recursive**

```bash
# Initialize and update submodules
git submodule init
git submodule update --recursive

# OR use the management script
./submodule-manager.sh init
```

### **Setup Development Environment**

```bash
# Use the management script (recommended)
./submodule-manager.sh setup

# OR manually
./submodule-manager.ps1 setup  # Windows PowerShell
```

## 🔄 **Common Operations**

### **Update All Submodules to Latest**

```bash
# Update all submodules to their latest versions
git submodule update --remote --recursive

# OR use management script
./submodule-manager.sh update
```

### **Check Status of All Submodules**

```bash
# Check status using management script
./submodule-manager.sh status

# OR manually
git submodule status --recursive
git submodule summary
```

### **Working on a Specific Submodule**

```bash
# Navigate to submodule
cd fl-fog

# Make changes
git checkout -b feature/new-feature
# ... make changes ...
git add .
git commit -m "feat: Add new feature"
git push origin feature/new-feature

# Go back to main repository
cd ..

# Update main repository to point to new commit
git add fl-fog
git commit -m "feat: Update fl-fog submodule with new feature"
git push origin main
```

### **Run Tests Across All Modules**

```bash
# Run all tests using management script
./submodule-manager.sh test

# OR manually run CI for main repo
./test_ci_local.sh  # Linux/Mac
./test_ci_local.ps1  # Windows
```

## 📖 **Management Scripts**

Two scripts are provided for easier submodule management:

### **Bash Script (Linux/Mac)**
```bash
./submodule-manager.sh <command> [arguments]
```

### **PowerShell Script (Windows)**
```powershell
./submodule-manager.ps1 <command> [arguments]
```

### **Available Commands**

| Command | Description | Example |
|---------|-------------|---------|
| `clone <url>` | Clone repository with all submodules | `./submodule-manager.sh clone <repo-url>` |
| `init` | Initialize and update submodules | `./submodule-manager.sh init` |
| `update` | Update all submodules to latest versions | `./submodule-manager.sh update` |
| `status` | Show status of all submodules | `./submodule-manager.sh status` |
| `commit <msg>` | Commit submodule updates | `./submodule-manager.sh commit "Update modules"` |
| `setup` | Setup development environment | `./submodule-manager.sh setup` |
| `test` | Run tests across all modules | `./submodule-manager.sh test` |
| `help` | Show help message | `./submodule-manager.sh help` |

## 🔧 **Advanced Operations**

### **Add a New Submodule**

```bash
# Add new submodule
git submodule add https://github.com/user/new-module.git new-module

# Commit the addition
git commit -m "feat: Add new-module as submodule"
git push origin main
```

### **Remove a Submodule**

```bash
# Remove submodule from .gitmodules
git rm --cached submodule-name
rm -rf submodule-name

# Edit .gitmodules to remove the entry
# Commit changes
git commit -m "feat: Remove submodule-name submodule"
git push origin main
```

### **Update Submodule URL**

```bash
# Edit .gitmodules file to change URL
# Then update the configuration
git submodule sync
git submodule update --init --recursive
```

## 🐛 **Troubleshooting**

### **Submodule Shows as Modified But No Changes**

```bash
# Reset submodule to clean state
cd submodule-name
git checkout .
cd ..
git submodule update
```

### **Submodule Stuck in Detached HEAD**

```bash
cd submodule-name
git checkout main  # or appropriate branch
cd ..
git add submodule-name
git commit -m "Update submodule to track main branch"
```

### **Force Update All Submodules**

```bash
git submodule foreach --recursive git reset --hard
git submodule update --init --recursive --force
```

## 📚 **Best Practices**

1. **Always use `--recursive`** when cloning
2. **Test locally** before pushing submodule updates
3. **Keep submodules up to date** regularly
4. **Use feature branches** in submodules for new features
5. **Document changes** in both submodule and main repository
6. **Use management scripts** for consistency across team

## 🔗 **Repository Links**

- **Main Repository**: [TFM-Federated-learning-on-edge-nodes](https://github.com/adrianoggm/TFM-Federated-learning-on-edge-nodes)
- **FL-Common**: [fl-common](https://github.com/adrianoggm/fl-common)
- **FL-Fog**: [fl-fog](https://github.com/adrianoggm/fl-fog)
- **FL-Client**: [fl-client](https://github.com/adrianoggm/fl-client)
- **FL-Server**: [fl-server](https://github.com/adrianoggm/fl-server)
- **FL-ML-Models**: [fl-ml-models](https://github.com/adrianoggm/fl-ml-models)

## 🆘 **Need Help?**

If you encounter issues with submodules:

1. Check this guide first
2. Use `./submodule-manager.sh status` to diagnose
3. Try `./submodule-manager.sh setup` to reset environment
4. Check individual submodule documentation
5. Create an issue in the main repository
