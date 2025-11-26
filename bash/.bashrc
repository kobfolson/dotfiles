# .bashrc - Git Bash Configuration for Windows
# Sourced for interactive non-login shells

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source modules
if [ -d "$HOME/.config/bash/modules" ]; then
    for module in "$HOME/.config/bash/modules"/*.bash; do
        [ -f "$module" ] && source "$module"
    done
fi

# Source functions
if [ -d "$HOME/.config/bash/functions" ]; then
    for func in "$HOME/.config/bash/functions"/*; do
        [ -f "$func" ] && source "$func"
    done
fi

# XDG Base Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-/c/dev/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-/c/dev/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-/c/dev/.cache}"

# Environment variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# History configuration
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Better bash behavior
shopt -s checkwinsize
shopt -s globstar
shopt -s nocaseglob
shopt -s cdspell
shopt -s dirspell

# Enable programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Git Bash on Windows specific
export MSYS=winsymlinks:nativestrict

# Add local bin to PATH
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Add scoop to PATH (if installed)
[ -d "$HOME/scoop/shims" ] && export PATH="$HOME/scoop/shims:$PATH"

# direnv integration
if command -v direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

# starship prompt (if installed)
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Print welcome message
echo "Git Bash loaded successfully!"
