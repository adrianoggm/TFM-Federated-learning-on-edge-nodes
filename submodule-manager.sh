#!/bin/bash
# Submodule Management Script
# This script helps manage Git submodules in the federated learning project

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_section() {
    echo -e "${BLUE}🔧 $1${NC}"
    echo "----------------------------------------"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

# Function to clone with submodules
clone_with_submodules() {
    print_section "Cloning repository with all submodules"
    
    if [ $# -eq 0 ]; then
        echo "Usage: ./submodule-manager.sh clone <repository-url>"
        exit 1
    fi
    
    git clone --recursive "$1"
    print_success "Repository cloned with all submodules"
}

# Function to initialize submodules
init_submodules() {
    print_section "Initializing and updating submodules"
    
    git submodule init
    git submodule update --recursive
    
    print_success "All submodules initialized and updated"
}

# Function to update all submodules to latest
update_submodules() {
    print_section "Updating all submodules to latest versions"
    
    git submodule update --remote --recursive
    
    print_success "All submodules updated to latest versions"
}

# Function to check submodule status
status_submodules() {
    print_section "Checking submodule status"
    
    echo -e "${YELLOW}Main repository status:${NC}"
    git status --short
    echo ""
    
    echo -e "${YELLOW}Submodule status:${NC}"
    git submodule status --recursive
    echo ""
    
    echo -e "${YELLOW}Submodule summary:${NC}"
    git submodule summary
}

# Function to commit submodule updates
commit_submodule_updates() {
    print_section "Committing submodule updates"
    
    if [ $# -eq 0 ]; then
        echo "Usage: ./submodule-manager.sh commit <commit-message>"
        exit 1
    fi
    
    git add .gitmodules
    git submodule foreach git add .
    git add .
    git commit -m "$1"
    
    print_success "Submodule updates committed"
}

# Function to setup development environment
setup_dev() {
    print_section "Setting up development environment"
    
    # Initialize submodules if not already done
    git submodule init
    git submodule update --recursive
    
    # Install dependencies for each submodule
    for submodule in fl-common fl-fog fl-client fl-server fl-ml-models; do
        if [ -d "$submodule" ] && [ -f "$submodule/requirements.txt" ]; then
            print_info "Installing dependencies for $submodule"
            cd "$submodule"
            pip install -r requirements.txt || echo "Warning: Some dependencies failed to install for $submodule"
            cd ..
        fi
    done
    
    # Install root dependencies
    if [ -f "requirements.txt" ]; then
        print_info "Installing root dependencies"
        pip install -r requirements.txt
    fi
    
    print_success "Development environment setup complete"
}

# Function to run tests across all modules
test_all() {
    print_section "Running tests across all modules"
    
    # Run main repository CI
    if [ -f "test_ci_local.sh" ]; then
        print_info "Running main repository CI tests"
        ./test_ci_local.sh
    fi
    
    # Run individual module tests
    for submodule in fl-fog fl-client fl-server fl-common fl-ml-models; do
        if [ -d "$submodule" ] && [ -f "$submodule/test_ci_local.sh" ]; then
            print_info "Running tests for $submodule"
            cd "$submodule"
            ./test_ci_local.sh || echo "Warning: Tests failed for $submodule"
            cd ..
        fi
    done
    
    print_success "All tests completed"
}

# Function to show help
show_help() {
    echo "Federated Learning Submodule Manager"
    echo "===================================="
    echo ""
    echo "Usage: ./submodule-manager.sh <command> [arguments]"
    echo ""
    echo "Commands:"
    echo "  clone <url>     Clone repository with all submodules"
    echo "  init            Initialize and update submodules"
    echo "  update          Update all submodules to latest versions"
    echo "  status          Show status of all submodules"
    echo "  commit <msg>    Commit submodule updates"
    echo "  setup           Setup development environment"
    echo "  test            Run tests across all modules"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./submodule-manager.sh clone https://github.com/user/repo.git"
    echo "  ./submodule-manager.sh update"
    echo "  ./submodule-manager.sh commit 'Update submodules to latest versions'"
    echo "  ./submodule-manager.sh setup"
}

# Main script logic
case "${1:-help}" in
    clone)
        clone_with_submodules "$2"
        ;;
    init)
        init_submodules
        ;;
    update)
        update_submodules
        ;;
    status)
        status_submodules
        ;;
    commit)
        commit_submodule_updates "$2"
        ;;
    setup)
        setup_dev
        ;;
    test)
        test_all
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use './submodule-manager.sh help' for usage information"
        exit 1
        ;;
esac
