SHELL=/bin/bash

export DIRS := alacritty bat git mpv tmux zsh
export PKGS := black mypy flake8 isort

install_brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
	eval "$(/opt/homebrew/bin/brew shellenv)"

run_brewfile:
	brew bundle

stow_dirs:
	$(foreach dir,$(DIRS),$(shell stow -Rv --no-folding $(dir)))

py_linters:
	$(foreach pkg,$(PKGS),$(shell pipx install $(pkg)))

system:
	# Dark interface is best interface
	defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

	# Autohide the dock
	defaults write com.apple.dock autohide -int 1

	# Change location of screenshots
	mkdir -p $HOME/Pictures/Screenshots
	defaults write com.apple.screencapture location $HOME/Pictures/Screenshots

all: install_brew run_brewfile stow_dirs py_linters system