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

# Go binaries
if [ -d "$HOME/go/bin" ]; then
    export GOPATH="$HOME/go"
    add_to_path "$GOPATH/bin"
fi

# Rust/Cargo binaries
add_to_path "$HOME/.cargo/bin"
