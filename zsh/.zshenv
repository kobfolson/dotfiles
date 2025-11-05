#
# zshenv
#

# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# Standard Linux paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin${PATH+:$PATH}"

# XDG Base Directories
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# ZDOTDIR
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Local configuration file.
export LOCALRC="$ZDOTDIR/.local"
