# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
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

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
