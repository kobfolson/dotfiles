SHELL=/bin/bash

export DIRS := bat git mpv wezterm zsh direnv ruff

.ONESHELL:
.PHONY: install_brew
install_brew:
	@echo "Installing Homebrew..."
	@curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
	@echo "Setting up Homebrew environment..."
	@eval "$$(/opt/homebrew/bin/brew shellenv)"

.PHONY: run_brewfile
run_brewfile:
	brew bundle

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
	mise use --global go@latest
	mise use --global node@lts

.PHONY: setup_uv_tools
setup_uv_tools:
	@echo "Installing ruff via uv..."
	@uv tool install ruff

.PHONY: system
system:
	# Dark interface is best interface
	defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

	# Autohide the dock
	defaults write com.apple.dock autohide -int 1

	# Enable key repeat
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

	# Change location of screenshots
	mkdir -p $$HOME/Pictures/Screenshots
	defaults write com.apple.screencapture location $$HOME/Pictures/Screenshots

.PHONY: all
all: run_brewfile stow_dirs setup_mise setup_uv_tools system
