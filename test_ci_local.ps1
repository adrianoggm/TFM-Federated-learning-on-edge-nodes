# Local CI Test Script for Windows PowerShell
# This script runs the same checks that the GitHub CI will run

param(
    [switch]$Fix,
    [switch]$Verbose
)

$ErrorActionPreference = "Continue"

# Function to run command with timeout
function Invoke-CommandWithTimeout {
    param(
        [string]$Command,
        [int]$TimeoutSeconds = 300
    )
    
    $job = Start-Job -ScriptBlock { 
        param($cmd)
        Invoke-Expression $cmd
    } -ArgumentList $Command
    
    if (Wait-Job $job -Timeout $TimeoutSeconds) {
        $result = Receive-Job $job
        Remove-Job $job
        return $result
    } else {
        Remove-Job $job -Force
        throw "Command timed out after $TimeoutSeconds seconds: $Command"
    }
}

Write-Host "🚀 Running Local CI Tests..." -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# Function to print status
function Write-Status {
    param($Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param($Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

function Write-Error {
    param($Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

# Check if we're in the right directory
if (-not (Test-Path "pyproject.toml")) {
    Write-Error "Not in project root directory. Please run from TFM-Federated-learning-on-edge-nodes/"
    exit 1
}

Write-Host "📦 Installing dependencies..." -ForegroundColor Cyan
Write-Host "   Upgrading pip..."
try {
    if ($Verbose) {
        python -m pip install --upgrade pip
    } else {
        python -m pip install --upgrade pip --quiet
    }
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to upgrade pip (exit code: $LASTEXITCODE)"
    }
} catch {
    Write-Warning "Failed to upgrade pip: $($_.Exception.Message)"
}

Write-Host "   Installing development tools..."
try {
    if ($Verbose) {
        pip install black isort flake8 mypy pytest
    } else {
        pip install black isort flake8 mypy pytest --quiet
    }
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to install some development tools (exit code: $LASTEXITCODE)"
    }
} catch {
    Write-Warning "Failed to install development tools: $($_.Exception.Message)"
}

# Install project dependencies
$projects = @("fl-client", "fl-server", "fl-common", "fl-ml-models")
foreach ($dir in $projects) {
    if ((Test-Path $dir) -and (Test-Path "$dir/requirements.txt")) {
        Write-Host "   Installing $dir dependencies..."
        try {
            if ($Verbose) {
                pip install -r "$dir/requirements.txt"
            } else {
                pip install -r "$dir/requirements.txt" --quiet
            }
            if ($LASTEXITCODE -ne 0) {
                Write-Warning "Some dependencies for $dir failed to install (exit code: $LASTEXITCODE)"
            }
        } catch {
            Write-Warning "Failed to install $dir dependencies: $($_.Exception.Message)"
        }
    }
}

if (Test-Path "requirements.txt") {
    Write-Host "   Installing root dependencies..."
    try {
        if ($Verbose) {
            pip install -r requirements.txt
        } else {
            pip install -r requirements.txt --quiet
        }
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Some root dependencies failed to install (exit code: $LASTEXITCODE)"
        }
    } catch {
        Write-Warning "Failed to install root dependencies: $($_.Exception.Message)"
    }
}

Write-Status "Dependencies installed"

Write-Host ""
Write-Host "🎨 Running format checks..." -ForegroundColor Cyan
Write-Host "----------------------------"

$formatIssues = 0

foreach ($dir in $projects) {
    if (Test-Path $dir) {
        Write-Host "   Checking $dir formatting..."
        
        # Check Black formatting
        $blackResult = & black --check "$dir/" 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Black formatting issues in $dir/"
            if ($Verbose) { Write-Host $blackResult }
            $formatIssues++
            
            if ($Fix) {
                Write-Host "   Fixing Black formatting in $dir..." -ForegroundColor Blue
                & black "$dir/"
            }
        }
        
        # Check import sorting
        $isortResult = & isort --check-only "$dir/" 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Import sorting issues in $dir/"
            if ($Verbose) { Write-Host $isortResult }
            $formatIssues++
            
            if ($Fix) {
                Write-Host "   Fixing import sorting in $dir..." -ForegroundColor Blue
                & isort "$dir/"
            }
        }
    }
}

if ($formatIssues -eq 0) {
    Write-Status "All formatting checks passed"
} else {
    Write-Warning "$formatIssues formatting issues found"
    if (-not $Fix) {
        Write-Host "   Run with -Fix parameter to automatically fix formatting issues"
    }
}

Write-Host ""
Write-Host "🔍 Running linting..." -ForegroundColor Cyan
Write-Host "--------------------"

$lintIssues = 0

foreach ($dir in $projects) {
    if (Test-Path $dir) {
        Write-Host "   Linting $dir..."
        $flakeResult = & flake8 "$dir/" 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Linting issues in $dir/"
            if ($Verbose) { Write-Host $flakeResult }
            $lintIssues++
        }
    }
}

if ($lintIssues -eq 0) {
    Write-Status "All linting checks passed"
} else {
    Write-Warning "$lintIssues directories have linting issues"
}

Write-Host ""
Write-Host "🔧 Running type checks..." -ForegroundColor Cyan
Write-Host "------------------------"

$typeIssues = 0

if (Test-Path "fl-client/fl_client") {
    Write-Host "   Type checking fl-client..."
    $mypyResult = & mypy "fl-client/fl_client" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Type checking issues in fl-client/"
        if ($Verbose) { Write-Host $mypyResult }
        $typeIssues++
    }
}

if (Test-Path "fl-server/fl_server") {
    Write-Host "   Type checking fl-server..."
    $mypyResult = & mypy "fl-server/fl_server" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Type checking issues in fl-server/"
        if ($Verbose) { Write-Host $mypyResult }
        $typeIssues++
    }
}

if (Test-Path "fl-common/src") {
    Write-Host "   Type checking fl-common..."
    $mypyResult = & mypy "fl-common/src" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Type checking issues in fl-common/"
        if ($Verbose) { Write-Host $mypyResult }
        $typeIssues++
    }
}

if (Test-Path "fl-ml-models") {
    Write-Host "   Type checking fl-ml-models..."
    $mypyResult = & mypy "fl-ml-models" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Type checking issues in fl-ml-models/"
        if ($Verbose) { Write-Host $mypyResult }
        $typeIssues++
    }
}

if ($typeIssues -eq 0) {
    Write-Status "All type checks passed"
} else {
    Write-Warning "$typeIssues directories have type checking issues"
}

Write-Host ""
Write-Host "🧪 Running tests..." -ForegroundColor Cyan
Write-Host "------------------"

$testIssues = 0

foreach ($dir in $projects) {
    if (Test-Path "$dir/tests") {
        Write-Host "   Running tests in $dir..."
        Push-Location $dir
        try {
            $testResult = & python -m pytest tests/ --maxfail=1 --disable-warnings -q 2>&1
            if ($LASTEXITCODE -ne 0) {
                Write-Warning "Test failures in $dir/"
                if ($Verbose) { Write-Host $testResult }
                $testIssues++
            }
        }
        finally {
            Pop-Location
        }
    } else {
        Write-Host "   No tests found in $dir/"
    }
}

if ($testIssues -eq 0) {
    Write-Status "All tests passed"
} else {
    Write-Warning "$testIssues directories have test failures"
}

Write-Host ""
Write-Host "📊 Summary" -ForegroundColor Cyan
Write-Host "=========="

$totalIssues = $formatIssues + $lintIssues + $typeIssues + $testIssues

if ($totalIssues -eq 0) {
    Write-Status "All checks passed! 🎉"
    Write-Host "Your code is ready for CI/CD pipeline."
} else {
    Write-Warning "Found issues in $totalIssues categories:"
    if ($formatIssues -gt 0) { Write-Host "   - Formatting issues: $formatIssues" }
    if ($lintIssues -gt 0) { Write-Host "   - Linting issues: $lintIssues" }
    if ($typeIssues -gt 0) { Write-Host "   - Type checking issues: $typeIssues" }
    if ($testIssues -gt 0) { Write-Host "   - Test failures: $testIssues" }
    Write-Host ""
    Write-Host "Fix these issues before pushing to avoid CI failures."
}

Write-Host ""
Write-Host "🔧 Quick fixes:" -ForegroundColor Cyan
Write-Host "  Format code: black fl-client/ fl-server/ fl-common/ fl-ml-models/"
Write-Host "  Sort imports: isort fl-client/ fl-server/ fl-common/ fl-ml-models/"
Write-Host "  Check linting: flake8 fl-client/ fl-server/ fl-common/ fl-ml-models/"
Write-Host "  Check types: mypy fl-client/fl_client fl-server/fl_server fl-common/src fl-ml-models"
Write-Host "  Run tests: cd [project]; python -m pytest tests/"
Write-Host ""
Write-Host "  Or run this script with -Fix to automatically fix formatting issues"

exit $totalIssues
