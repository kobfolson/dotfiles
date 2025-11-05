#!/usr/bin/env bash
#
# Windows dotfiles setup script for Git Bash
# Automates installation of packages and configuration
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories to stow
STOW_DIRS=(bash git bat direnv)

# Function to print colored messages
print_msg() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install Scoop
install_scoop() {
    if command_exists scoop; then
        print_success "Scoop is already installed"
        return 0
    fi

    print_msg "Installing Scoop package manager..."
    powershell.exe -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))"

    if [ $? -eq 0 ]; then
        print_success "Scoop installed successfully"
        # Add scoop to PATH for this session
        export PATH="$HOME/scoop/shims:$PATH"
    else
        print_error "Failed to install Scoop"
        return 1
    fi
}

# Function to install packages from Scoopfile
install_scoop_packages() {
    if ! command_exists scoop; then
        print_error "Scoop not found. Please install Scoop first."
        return 1
    fi

    print_msg "Adding Scoop buckets..."
    scoop bucket add extras
    scoop bucket add nerd-fonts

    if [ -f "Scoopfile.json" ]; then
        print_msg "Installing packages from Scoopfile.json..."
        scoop import Scoopfile.json
        print_success "Scoop packages installed"
    else
        print_warning "Scoopfile.json not found, skipping package installation"
    fi
}

# Function to stow configuration directories
stow_configs() {
    if ! command_exists stow; then
        print_error "GNU Stow not found. Installing via Scoop..."
        scoop install stow
    fi

    print_msg "Stowing configuration directories..."

    for dir in "${STOW_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            print_msg "  Stowing $dir..."
            if stow -v --no-folding "$dir" 2>&1; then
                print_success "  $dir stowed successfully"
            else
                print_warning "  $dir may have conflicts (this is normal if configs already exist)"
            fi
        else
            print_warning "  Directory $dir not found, skipping"
        fi
    done
}

# Function to install Python tools via uv
install_python_tools() {
    if ! command_exists uv; then
        print_msg "Installing uv (modern Python package manager)..."
        scoop install uv
    fi

    print_msg "Installing Python development tools..."
    local tools=(ruff mypy)

    for tool in "${tools[@]}"; do
        print_msg "  Installing $tool..."
        uv tool install "$tool" || print_warning "  Failed to install $tool"
    done

    print_success "Python development tools installed (ruff, mypy)"
    print_msg "Note: Use 'uv' for Python package and project management"
}

# Main setup function
main() {
    print_msg "Starting Windows dotfiles setup..."
    echo ""

    # Change to dotfiles directory
    cd "$(dirname "$0")"

    print_msg "Current directory: $(pwd)"
    echo ""

    # Install Scoop
    install_scoop
    echo ""

    # Install Scoop packages
    install_scoop_packages
    echo ""

    # Stow configurations
    stow_configs
    echo ""

    # Ask about Python tools
    read -p "Install Python development tools (ruff, mypy via uv)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_python_tools
        echo ""
    fi

    print_success "Setup complete!"
    echo ""
    print_msg "Next steps:"
    echo "  1. Restart Git Bash to load new configurations"
    echo "  2. Run 'source ~/.bashrc' to reload your profile in the current session"
    echo "  3. Configure Windows Terminal (optional) to use Git Bash"
    echo ""
    print_msg "Additional setup:"
    echo "  - Edit ~/.bashrc for custom configurations"
    echo "  - Run 'scoop search <package>' to find more packages"
    echo "  - Use 'stow -v <directory>' to add more configs"
}

# Run main function
main
