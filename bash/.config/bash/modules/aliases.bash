#!/usr/bin/env bash
#
# Aliases
#

# Directory navigation
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd='rmdir'
alias d='dirs -v | head -10'

alias '?'='pwd'

# List directory contents
if command -v eza &> /dev/null; then
  alias ls='eza --group-directories-first --git'
  alias l='ls -l'
  alias ll='ls -lah'
  alias la='ls -lah'
  alias lx='ls -l --sort extension'
  alias lt='ls -T'
elif command -v exa &> /dev/null; then
  alias ls='exa --group-directories-first --git'
  alias l='ls -l'
  alias ll='ls -lah'
  alias la='ls -lah'
  alias lx='ls -l --sort extension'
  alias lt='ls -T'
else
  alias ls='ls -F --color=auto --group-directories-first'
  alias l='ls -lh'
  alias ll='ls -lAh'
  alias la='ls -lah'
  alias lx='ls -lXB'
  command -v tree &> /dev/null && alias lt='tree'
fi

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Sudo equivalent (Windows - run as admin)
alias _='runas /user:Administrator'
alias chmox='chmod +x'

# Pretty print the path
alias path='echo -e ${PATH//:/\\n}'

# Conditional aliases
command -v bat &> /dev/null && alias cat='bat'
command -v nvim &> /dev/null && alias vim='nvim'
command -v python3 &> /dev/null && alias server='python3 -m http.server 8080'
command -v python &> /dev/null && alias server='python -m http.server 8080'

# htop/btop
if command -v btop &> /dev/null; then
  alias top='btop'
elif command -v htop &> /dev/null; then
  alias top='htop'
fi

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# Docker shortcuts
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'

# Windows-specific
alias open='explorer'
alias clip='clip.exe'
