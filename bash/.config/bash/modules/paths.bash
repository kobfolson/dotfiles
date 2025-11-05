#!/usr/bin/env bash
#
# Path management
#

# Function to add to PATH if not already present
add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# Add common directories to PATH
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"
add_to_path "$HOME/scoop/shims"
add_to_path "/c/Program Files/Git/cmd"

# Python user site packages (pipx, etc.)
if command -v python &> /dev/null; then
    PYTHON_USER_BASE=$(python -m site --user-base 2>/dev/null)
    add_to_path "$PYTHON_USER_BASE/Scripts"
fi

# Node.js global packages
if [ -d "$APPDATA/npm" ]; then
    add_to_path "$APPDATA/npm"
fi

# Go binaries
if [ -d "$HOME/go/bin" ]; then
    export GOPATH="$HOME/go"
    add_to_path "$GOPATH/bin"
fi

# Rust/Cargo binaries
add_to_path "$HOME/.cargo/bin"
