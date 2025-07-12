# Submodule Management Script for Windows PowerShell
# This script helps manage Git submodules in the federated learning project

param(
    [Parameter(Position=0)]
    [string]$Command = "help",
    
    [Parameter(Position=1)]
    [string]$Argument = ""
)

$ErrorActionPreference = "Continue"

# Function to print colored output
function Write-Section {
    param($Message)
    Write-Host "🔧 $Message" -ForegroundColor Blue
    Write-Host "----------------------------------------" -ForegroundColor Blue
}

function Write-Success {
    param($Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Info {
    param($Message)
    Write-Host "ℹ️  $Message" -ForegroundColor Yellow
}

function Write-Warning {
    param($Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

# Function to clone with submodules
function Invoke-CloneWithSubmodules {
    param($RepoUrl)
    
    if (-not $RepoUrl) {
        Write-Error "Usage: .\submodule-manager.ps1 clone <repository-url>"
        exit 1
    }
    
    Write-Section "Cloning repository with all submodules"
    
    git clone --recursive $RepoUrl
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Repository cloned with all submodules"
    } else {
        Write-Error "Failed to clone repository"
        exit 1
    }
}

# Function to initialize submodules
function Initialize-Submodules {
    Write-Section "Initializing and updating submodules"
    
    git submodule init
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to initialize some submodules"
    }
    
    git submodule update --recursive
    if ($LASTEXITCODE -eq 0) {
        Write-Success "All submodules initialized and updated"
    } else {
        Write-Warning "Some submodules failed to update"
    }
}

# Function to update all submodules to latest
function Update-Submodules {
    Write-Section "Updating all submodules to latest versions"
    
    git submodule update --remote --recursive
    if ($LASTEXITCODE -eq 0) {
        Write-Success "All submodules updated to latest versions"
    } else {
        Write-Warning "Some submodules failed to update"
    }
}

# Function to check submodule status
function Get-SubmoduleStatus {
    Write-Section "Checking submodule status"
    
    Write-Info "Main repository status:"
    git status --short
    Write-Host ""
    
    Write-Info "Submodule status:"
    git submodule status --recursive
    Write-Host ""
    
    Write-Info "Submodule summary:"
    git submodule summary
}

# Function to commit submodule updates
function Commit-SubmoduleUpdates {
    param($CommitMessage)
    
    if (-not $CommitMessage) {
        Write-Error "Usage: .\submodule-manager.ps1 commit <commit-message>"
        exit 1
    }
    
    Write-Section "Committing submodule updates"
    
    git add .gitmodules
    git submodule foreach git add .
    git add .
    git commit -m $CommitMessage
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Submodule updates committed"
    } else {
        Write-Warning "Failed to commit submodule updates"
    }
}

# Function to setup development environment
function Setup-DevEnvironment {
    Write-Section "Setting up development environment"
    
    # Initialize submodules if not already done
    git submodule init
    git submodule update --recursive
    
    # Install dependencies for each submodule
    $submodules = @("fl-common", "fl-fog", "fl-client", "fl-server", "fl-ml-models")
    
    foreach ($submodule in $submodules) {
        if ((Test-Path $submodule) -and (Test-Path "$submodule/requirements.txt")) {
            Write-Info "Installing dependencies for $submodule"
            Push-Location $submodule
            try {
                pip install -r requirements.txt
                if ($LASTEXITCODE -ne 0) {
                    Write-Warning "Some dependencies failed to install for $submodule"
                }
            }
            finally {
                Pop-Location
            }
        }
    }
    
    # Install root dependencies
    if (Test-Path "requirements.txt") {
        Write-Info "Installing root dependencies"
        pip install -r requirements.txt
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Some root dependencies failed to install"
        }
    }
    
    Write-Success "Development environment setup complete"
}

# Function to run tests across all modules
function Test-AllModules {
    Write-Section "Running tests across all modules"
    
    # Run main repository CI
    if (Test-Path "test_ci_local.ps1") {
        Write-Info "Running main repository CI tests"
        .\test_ci_local.ps1
    }
    
    # Run individual module tests
    $submodules = @("fl-fog", "fl-client", "fl-server", "fl-common", "fl-ml-models")
    
    foreach ($submodule in $submodules) {
        if ((Test-Path $submodule) -and (Test-Path "$submodule/test_ci_local.ps1")) {
            Write-Info "Running tests for $submodule"
            Push-Location $submodule
            try {
                .\test_ci_local.ps1
                if ($LASTEXITCODE -ne 0) {
                    Write-Warning "Tests failed for $submodule"
                }
            }
            finally {
                Pop-Location
            }
        }
    }
    
    Write-Success "All tests completed"
}

# Function to show help
function Show-Help {
    Write-Host "Federated Learning Submodule Manager" -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: .\submodule-manager.ps1 <command> [arguments]" -ForegroundColor Green
    Write-Host ""
    Write-Host "Commands:" -ForegroundColor Yellow
    Write-Host "  clone <url>     Clone repository with all submodules"
    Write-Host "  init            Initialize and update submodules"
    Write-Host "  update          Update all submodules to latest versions"
    Write-Host "  status          Show status of all submodules"
    Write-Host "  commit <msg>    Commit submodule updates"
    Write-Host "  setup           Setup development environment"
    Write-Host "  test            Run tests across all modules"
    Write-Host "  help            Show this help message"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Cyan
    Write-Host "  .\submodule-manager.ps1 clone https://github.com/user/repo.git"
    Write-Host "  .\submodule-manager.ps1 update"
    Write-Host "  .\submodule-manager.ps1 commit 'Update submodules to latest versions'"
    Write-Host "  .\submodule-manager.ps1 setup"
}

# Main script logic
switch ($Command.ToLower()) {
    "clone" {
        Invoke-CloneWithSubmodules $Argument
    }
    "init" {
        Initialize-Submodules
    }
    "update" {
        Update-Submodules
    }
    "status" {
        Get-SubmoduleStatus
    }
    "commit" {
        Commit-SubmoduleUpdates $Argument
    }
    "setup" {
        Setup-DevEnvironment
    }
    "test" {
        Test-AllModules
    }
    default {
        if ($Command -eq "help" -or $Command -eq "--help" -or $Command -eq "-h") {
            Show-Help
        } else {
            Write-Error "Unknown command: $Command"
            Write-Host "Use '.\submodule-manager.ps1 help' for usage information"
            exit 1
        }
    }
}
