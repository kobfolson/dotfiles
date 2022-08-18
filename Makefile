SHELL=/bin/zsh

export DIRS := alacritty bat git mpv tmux zsh
export PKGS := black mypy flake8 isort

.ONESHELL:
.PHONY: install_brew
install_brew:
	sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash \
		&& eval "$$(/opt/homebrew/bin/brew shellenv)" | bash

run_brewfile:
	brew bundle

stow_dirs:
	$(foreach dir,$(DIRS),$(shell stow -Rv --no-folding $(dir)))

py_linters:
	$(foreach pkg,$(PKGS),$(shell pipx install $(pkg)))

setup_anyenv:
	anyenv install --init git@github.com:idadzie/anyenv-install.git

system:
	# Dark interface is best interface
	defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

	# Autohide the dock
	defaults write com.apple.dock autohide -int 1

	# Change location of screenshots
	mkdir -p $$HOME/Pictures/Screenshots
	defaults write com.apple.screencapture location $$HOME/Pictures/Screenshots

all: install_brew run_brewfile stow_dirs py_linters setup_anyenv system
