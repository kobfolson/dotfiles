#
# zshenv
#

# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# Homebrew 
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# XDG Base Directories
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# ZDOTDIR
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Local configuration file.
export LOCALRC="$ZDOTDIR/.local"

# Cargo (Rust) environment
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
