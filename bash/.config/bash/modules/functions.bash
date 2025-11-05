#!/usr/bin/env bash
#
# Useful functions
#

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick directory jumps
..() { cd ..; }
...() { cd ../..; }
....() { cd ../../..; }
.....() { cd ../../../..; }

# Extract various archive types
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Clean Python cache files
pyclean() {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
    find . -type d -name '.pytest_cache' -exec rm -rf {} + 2>/dev/null
    find . -type d -name '.mypy_cache' -exec rm -rf {} + 2>/dev/null
}

# Get system info
sysinfo() {
    echo "=== System Information ==="
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Hostname: $(hostname)"
    echo "User: $USER"
    echo "Shell: $SHELL"
    echo "Terminal: $TERM"
}

# What's on port
whats-on-port() {
    if [ -z "$1" ]; then
        echo "Usage: whats-on-port <port>"
        return 1
    fi
    netstat -ano | grep ":$1"
}

# Git current branch
current_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Quick backup
backup() {
    cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}
