SHELL=/bin/bash

export DIRS := alacritty bat git mpv tmux zsh direnv npm wget
export UV_TOOLS = mypy poetry

.ONESHELL:
.PHONY: update_system
update_system:
	sudo apt update && sudo apt upgrade -y

.PHONY: install_packages
install_packages:
	sudo apt update
	sudo apt install -y $$(grep -v '^#' packages.txt | grep -v '^$$' | tr '\n' ' ')

.PHONY: stow_dirs
stow_dirs:
	$(foreach dir,$(DIRS),$(shell stow -Rv --no-folding $(dir)))

.PHONY: py_tools
py_tools:
	@echo "Installing Python tools via uv..."
	@echo "Note: uv and ruff are installed via zinit (start zsh first)"
	@if command -v uv >/dev/null 2>&1; then \
		$(foreach tool,$(UV_TOOLS),uv tool install $(tool);) \
	else \
		echo "uv not found. Please start zsh to install zinit plugins, then run 'make py_tools'"; \
	fi

# Legacy alias
.PHONY: py_linters
py_linters: py_tools

.PHONY: setup_anyenv
setup_anyenv:
	anyenv install --init git@github.com:idadzie/anyenv-install.git

.PHONY: system
system:
	# Create standard directories
	mkdir -p $$HOME/Pictures/Screenshots
	mkdir -p $$HOME/.local/bin
	mkdir -p $$HOME/.config
	mkdir -p $$HOME/.cache
	mkdir -p $$HOME/.local/share
	mkdir -p $$HOME/.local/state

	# Set zsh as default shell (if not already)
	if [ "$$SHELL" != "$$(which zsh)" ]; then \
		chsh -s $$(which zsh); \
	fi

.PHONY: all
all: update_system install_packages stow_dirs setup_anyenv system
	@echo ""
	@echo "=== Setup Complete ==="
	@echo "Next steps:"
	@echo "1. Log out and back in (for shell change)"
	@echo "2. Start zsh (zinit will auto-install tools: uv, ruff, gh, eza, etc.)"
	@echo "3. Run 'make py_tools' to install Python dev tools via uv"
	@echo ""
