SHELL=/bin/bash

export DIRS := alacritty bat git mpv tmux zsh direnv
export PKGS = black mypy flake8 isort poetry

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

.PHONY: py_linters
py_linters:
	@for pkg in $(PKGS); do \
		echo "Installing $$pkg..."; \
		pipx install $$pkg; \
	done

.PHONY: setup_anyenv
setup_anyenv:
	anyenv install --init git@github.com:idadzie/anyenv-install.git

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
all: install_brew run_brewfile stow_dirs py_linters setup_anyenv system
