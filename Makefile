install_brew:
	xcode-select --install \
  		&& /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
			&& eval "$(/opt/homebrew/bin/brew shellenv)"

run_brewfile:
	brew bundle

system:
	# Dark interface is best interface
	defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

	# Autohide the dock
	defaults write com.apple.dock autohide -int 1

	# Change location of screenshots
	mkdir -p $HOME/Pictures/Screenshots
	defaults write com.apple.screencapture location $HOME/Pictures/Screenshots

all: install_brew run_brewfile system