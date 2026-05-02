#!/usr/bin/env bash
set -euo pipefail

OS=$(uname -s)

# ─── macOS ────────────────────────────────────────────────────────────────────
if [[ "$OS" == "Darwin" ]]; then
  if ! xcode-select -p &>/dev/null; then
    echo "==> Installing Xcode Command Line Tools..."
    echo "    A dialog will appear — click Install and wait for it to finish."
    xcode-select --install
    until xcode-select -p &>/dev/null; do
      sleep 5
    done
    echo "==> Xcode CLT installed."
  fi

  sudo xcodebuild -license accept

  if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "==> Running dotfiles setup..."
  make packages stow_dirs setup_mise setup_uv_tools system

# ─── Linux ────────────────────────────────────────────────────────────────────
elif [[ "$OS" == "Linux" ]]; then
  echo "==> Updating apt and installing base dependencies..."
  sudo apt-get update -y
  sudo apt-get install -y curl git make stow wget

  echo "==> Running dotfiles setup..."
  make packages stow_dirs setup_mise setup_uv_tools

else
  echo "Unsupported OS: $OS"
  exit 1
fi
