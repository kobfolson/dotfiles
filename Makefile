SHELL=/bin/bash
OS := $(shell uname -s)

ifeq ($(OS),Darwin)
export DIRS := bat git mpv wezterm zsh direnv ruff
else
export DIRS := bat git tmux zsh direnv ruff
endif

export PATH := $(HOME)/.local/bin:$(PATH)

.ONESHELL:

.PHONY: packages
packages:
ifeq ($(OS),Darwin)
	brew bundle
else
	bash linux/apt-repos.sh
	xargs sudo apt-get install -y < linux/packages.txt
	@command -v mise &>/dev/null || curl https://mise.run | sh
	@command -v uv &>/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh
endif

.PHONY: stow_dirs
stow_dirs:
	@for dir in $(DIRS); do \
		echo "Stowing $$dir..."; \
		stow -Rv --no-folding $$dir; \
	done

.PHONY: setup_mise
setup_mise:
	@echo "Installing tools via mise..."
	mise use --global terraform@latest
	mise use --global kubectl@latest
	mise use --global kustomize@latest
	mise use --global helm@latest
	mise use --global go@latest
	mise use --global node@lts

.PHONY: setup_uv_tools
setup_uv_tools:
	@echo "Installing ruff via uv..."
	@uv tool install ruff

.PHONY: system
system:
ifeq ($(OS),Darwin)
	defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
	defaults write com.apple.dock autohide -int 1
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	mkdir -p $$HOME/Pictures/Screenshots
	defaults write com.apple.screencapture location $$HOME/Pictures/Screenshots
else
	@echo "No system configuration for Linux."
endif

.PHONY: all
all: packages stow_dirs setup_mise setup_uv_tools system
