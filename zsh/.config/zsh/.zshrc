#
# zshrc
#

foreach module (
  paths.zsh
  term.zsh
  theme.zsh
  keymap.zsh
  widgets.zsh
  env.zsh
  options.zsh
  completion.zsh
  history.zsh
  window.zsh
  zinit.zsh
  aliases.zsh
) {
  source "$ZDOTDIR/modules/$module"
}

# Local plugins, completions, functions, etc.
[[ -e $LOCALRC ]] && . $LOCALRC

# Created by `pipx` on 2024-02-16 15:08:41
export PATH="$PATH:/Users/kobby/.local/bin"

export PATH="/opt/homebrew/bin:$PATH"

# pyenv settings
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
