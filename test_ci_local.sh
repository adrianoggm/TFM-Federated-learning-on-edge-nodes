#!/bin/bash
"""
Local CI Test Script

This script runs the same checks that the GitHub CI will run,
allowing you to test locally before pushing.
"""

set -e  # Exit on any error

echo "🚀 Running Local CI Tests..."
echo "================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
    print_error "Not in project root directory. Please run from TFM-Federated-learning-on-edge-nodes/"
    exit 1
fi

echo "📦 Installing dependencies..."
python -m pip install --upgrade pip > /dev/null 2>&1
pip install black isort flake8 mypy pytest > /dev/null 2>&1

# Install project dependencies
for dir in fl-client fl-server fl-common fl-ml-models fl-fog; do
    if [ -d "$dir" ] && [ -f "$dir/requirements.txt" ]; then
        echo "   Installing $dir dependencies..."
        pip install -r "$dir/requirements.txt" > /dev/null 2>&1 || print_warning "Some dependencies for $dir failed to install"
    fi
done

if [ -f "requirements.txt" ]; then
    echo "   Installing root dependencies..."
    pip install -r requirements.txt > /dev/null 2>&1 || print_warning "Some root dependencies failed to install"
fi

print_status "Dependencies installed"

echo ""
echo "🎨 Running format checks..."
echo "----------------------------"

# Format check
format_issues=0

for dir in fl-client fl-server fl-common fl-ml-models fl-fog; do
    if [ -d "$dir" ]; then
        echo "   Checking $dir formatting..."
        if ! black --check "$dir/" > /dev/null 2>&1; then
            print_warning "Black formatting issues in $dir/"
            format_issues=$((format_issues + 1))
        fi
        
        if ! isort --check-only "$dir/" > /dev/null 2>&1; then
            print_warning "Import sorting issues in $dir/"
            format_issues=$((format_issues + 1))
        fi
    fi
done

if [ $format_issues -eq 0 ]; then
    print_status "All formatting checks passed"
else
    print_warning "$format_issues formatting issues found"
    echo "   Run 'black fl-client/ fl-server/ fl-common/ fl-ml-models/ fl-fog/' to fix"
    echo "   Run 'isort fl-client/ fl-server/ fl-common/ fl-ml-models/ fl-fog/' to fix imports"
fi

echo ""
echo "🔍 Running linting..."
echo "--------------------"

# Linting
lint_issues=0

for dir in fl-client fl-server fl-common fl-ml-models fl-fog; do
    if [ -d "$dir" ]; then
        echo "   Linting $dir..."
        if ! flake8 "$dir/" > /dev/null 2>&1; then
            print_warning "Linting issues in $dir/"
            lint_issues=$((lint_issues + 1))
        fi
    fi
done

if [ $lint_issues -eq 0 ]; then
    print_status "All linting checks passed"
else
    print_warning "$lint_issues directories have linting issues"
fi

echo ""
echo "🔧 Running type checks..."
echo "------------------------"

# Type checking
type_issues=0

if [ -d "fl-client/fl_client" ]; then
    echo "   Type checking fl-client..."
    if ! mypy fl-client/fl_client > /dev/null 2>&1; then
        print_warning "Type checking issues in fl-client/"
        type_issues=$((type_issues + 1))
    fi
fi

if [ -d "fl-server/fl_server" ]; then
    echo "   Type checking fl-server..."
    if ! mypy fl-server/fl_server > /dev/null 2>&1; then
        print_warning "Type checking issues in fl-server/"
        type_issues=$((type_issues + 1))
    fi
fi

if [ -d "fl-common/src" ]; then
    echo "   Type checking fl-common..."
    if ! mypy fl-common/src > /dev/null 2>&1; then
        print_warning "Type checking issues in fl-common/"
        type_issues=$((type_issues + 1))
    fi
fi

if [ -d "fl-ml-models" ]; then
    echo "   Type checking fl-ml-models..."
    if ! mypy fl-ml-models > /dev/null 2>&1; then
        print_warning "Type checking issues in fl-ml-models/"
        type_issues=$((type_issues + 1))
    fi
fi

if [ -d "fl-fog/fog_node" ]; then
    echo "   Type checking fl-fog..."
    if ! mypy fl-fog/fog_node fl-fog/communication > /dev/null 2>&1; then
        print_warning "Type checking issues in fl-fog/"
        type_issues=$((type_issues + 1))
    fi
fi

if [ $type_issues -eq 0 ]; then
    print_status "All type checks passed"
else
    print_warning "$type_issues directories have type checking issues"
fi

echo ""
echo "🧪 Running tests..."
echo "------------------"

# Testing
test_issues=0

for dir in fl-client fl-server fl-common fl-ml-models fl-fog; do
    if [ -d "$dir/tests" ]; then
        echo "   Running tests in $dir..."
        if ! (cd "$dir" && python -m pytest tests/ --maxfail=1 --disable-warnings -q > /dev/null 2>&1); then
            print_warning "Test failures in $dir/"
            test_issues=$((test_issues + 1))
        fi
    else
        echo "   No tests found in $dir/"
    fi
done

if [ $test_issues -eq 0 ]; then
    print_status "All tests passed"
else
    print_warning "$test_issues directories have test failures"
fi

echo ""
echo "📊 Summary"
echo "=========="

total_issues=$((format_issues + lint_issues + type_issues + test_issues))

if [ $total_issues -eq 0 ]; then
    print_status "All checks passed! 🎉"
    echo "Your code is ready for CI/CD pipeline."
else
    print_warning "Found issues in $total_issues categories:"
    [ $format_issues -gt 0 ] && echo "   - Formatting issues: $format_issues"
    [ $lint_issues -gt 0 ] && echo "   - Linting issues: $lint_issues" 
    [ $type_issues -gt 0 ] && echo "   - Type checking issues: $type_issues"
    [ $test_issues -gt 0 ] && echo "   - Test failures: $test_issues"
    echo ""
    echo "Fix these issues before pushing to avoid CI failures."
fi

echo ""
echo "🔧 Quick fixes:"
echo "  Format code: black fl-client/ fl-server/ fl-common/ fl-ml-models/ fl-fog/"
echo "  Sort imports: isort fl-client/ fl-server/ fl-common/ fl-ml-models/ fl-fog/"
echo "  Check linting: flake8 fl-client/ fl-server/ fl-common/ fl-ml-models/ fl-fog/"
echo "  Check types: mypy fl-client/fl_client fl-server/fl_server fl-common/src fl-ml-models fl-fog/fog_node fl-fog/communication"
echo "  Run tests: cd <project> && python -m pytest tests/"

exit $total_issues
