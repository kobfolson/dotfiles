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

# Configuration directories to symlink
CONFIG_DIRS=(bash git bat direnv)

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

# Function to install Scoop packages
install_scoop_packages() {
    if ! command_exists scoop; then
        print_error "Scoop not found. Please install Scoop first."
        return 1
    fi

    print_msg "Adding Scoop buckets..."
    scoop bucket add extras 2>/dev/null || true
    scoop bucket add nerd-fonts 2>/dev/null || true

    print_msg "Installing CLI tools..."
    local cli_tools=(gh ghq fd bat ripgrep fzf wget neovim delta starship shellcheck eza btop)
    for tool in "${cli_tools[@]}"; do
        scoop install "$tool" 2>/dev/null || print_warning "  $tool already installed or not found"
    done

    print_msg "Installing development tools..."
    local dev_tools=(python lazydocker direnv)
    for tool in "${dev_tools[@]}"; do
        scoop install "$tool" 2>/dev/null || print_warning "  $tool already installed or not found"
    done

    print_msg "Installing fonts..."
    scoop install JetBrainsMono-NF CascadiaCode-NF 2>/dev/null || print_warning "  Fonts already installed or not found"

    print_success "Scoop packages installation complete"
}

# Function to create symlinks for configuration directories
symlink_configs() {
    print_msg "Creating symlinks for configuration directories..."

    local dotfiles_dir="$(pwd)"

    for dir in "${CONFIG_DIRS[@]}"; do
        if [ ! -d "$dir" ]; then
            print_warning "  Directory $dir not found, skipping"
            continue
        fi

        print_msg "  Symlinking $dir..."

        # Find all files and directories in the config directory
        find "$dir" -type f -o -type d | while read -r item; do
            # Skip the base directory itself
            [ "$item" = "$dir" ] && continue

            # Get relative path from config directory
            local rel_path="${item#$dir/}"
            local target="$HOME/$rel_path"
            local source="$dotfiles_dir/$item"

            # Create parent directory if needed
            local parent_dir="$(dirname "$target")"
            if [ ! -d "$parent_dir" ]; then
                mkdir -p "$parent_dir"
            fi

            # Skip if it's a directory (we only symlink files)
            [ -d "$item" ] && continue

            # Create symlink if target doesn't exist
            if [ -e "$target" ] || [ -L "$target" ]; then
                print_warning "    $rel_path already exists, skipping"
            else
                if ln -s "$source" "$target" 2>/dev/null; then
                    print_success "    Linked $rel_path"
                else
                    print_error "    Failed to link $rel_path (try running as Administrator or enable Developer Mode)"
                fi
            fi
        done
    done

    print_success "Configuration symlinks created"
}

# Function to install Python tools via uv
install_python_tools() {
    if ! command_exists uv; then
        print_error "uv not found. Please install uv first: https://docs.astral.sh/uv/getting-started/installation/"
        return 1
    fi

    print_msg "Installing Python development tools via uv..."
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

    # Create configuration symlinks
    symlink_configs
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
