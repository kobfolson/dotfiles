#!/usr/bin/env bash
set -euo pipefail

# ─── Xcode Command Line Tools ────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools..."
  echo "    A dialog will appear — click Install and wait for it to finish."
  xcode-select --install
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
  echo "==> Xcode CLT installed."
fi

# Accept the Xcode license (required before using git/compilers)
sudo xcodebuild -license accept

# ─── Homebrew ────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# ─── Dotfiles ────────────────────────────────────────────────────────────────
echo "==> Running dotfiles setup..."
make run_brewfile stow_dirs setup_mise setup_uv_tools system
