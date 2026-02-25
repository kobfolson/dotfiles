#
# Zinit, plugins & snippets
#

typeset -A ZINIT
ZINIT_HOME=$XDG_DATA_HOME/zinit
ZINIT[HOME_DIR]=$ZINIT_HOME
ZINIT[ZCOMPDUMP_PATH]=$XDG_CACHE_HOME/zsh/compdump

if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME/bin
  zcompile $ZINIT_HOME/bin/zinit.zsh
fi

source $ZINIT_HOME/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/compdump"

# Zinit extensions
zinit light-mode for zdharma-continuum/zinit-annex-bin-gem-node
zinit light-mode for zdharma-continuum/zinit-annex-readurl

# Commands
zinit light rupa/z

zinit ice as'program' pick"$ZPFX/bin/git-*" \
  make"PREFIX=$ZPFX" src'etc/git-extras-completion.zsh'
zinit light tj/git-extras

# Zinit does not provide a straight forward way to
# install accompanying man pages. Hence the mess/"genius" below.
# At least this way I won't forget to install the completion
# files, have to go back to the repo and manually add to FPATH
# on a new PC.
zinit as'null' wait lucid light-mode for \
  sbin'bin/git-dsf;bin/diff-so-fancy' zdharma-continuum/zsh-diff-so-fancy \
  sbin'emojify;fuzzy-emoji' src'fuzzy-emoji-zle.zsh' wfxr/emoji-cli

# Note: jq, shfmt, countdown, and fzf are better managed via Homebrew
# Install with: brew install jq shfmt countdown fzf
# zinit as'null' from'gh-r' lucid for \
#   mv'jq* -> jq' sbin stedolan/jq \
#   mv'shfmt* -> shfmt' sbin @mvdan/sh \
#   mv'countdown* -> countdown' sbin antonmedv/countdown \
#   sbin junegunn/fzf-bin

zinit wait lucid for \
  wfxr/forgit \
  sbin'bin/anyenv' \
    atload'export ANYENV_ROOT=$HOME/.local/anyenv; eval "$(anyenv init -)"' anyenv/anyenv

zinit as'null' wait lucid light-mode for \
  id-as'sdkman' run-atpull \
  atclone"wget https://get.sdkman.io/\?rcupdate=false -O scr.sh;
    SDKMAN_DIR=$HOME/.local/sdkman bash scr.sh" \
  atpull"SDKMAN_DIR=$HOME/.local/sdkman sdk selfupdate" \
  atinit"export SDKMAN_DIR=$HOME/.local/sdkman;
    source $HOME/.local/sdkman/bin/sdkman-init.sh" \
  zdharma-continuum/null

# Plugins
zinit light MichaelAquilina/zsh-you-should-use

zinit wait lucid for \
  atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions

# local omz_plugins
# omz_plugins=(
#   lib/git.zsh
#   plugins/git/git.plugin.zsh
#   plugins/extract/extract.plugin.zsh
#   plugins/encode64/encode64.plugin.zsh
#   themes/fishy.zsh-theme
# )
# zinit ice pick'dev/null' nocompletions blockf \
#   multisrc"${omz_plugins}"
# zinit light robbyrussell/oh-my-zsh

zinit lucid for \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::extract \
  as'completion' OMZP::extract/_extract \
  OMZP::encode64 \
  OMZP::terraform \
  OMZP::kubectl \
  OMZT::fishy

# Snippets
zinit ice wait lucid id-as'fzf-keybindings'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

zinit ice wait lucid id-as'fzf-completion'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'

# Completion
zinit ice wait'1' lucid as'completion' \
  id-as'docker-compose-completion' mv'docker-compose-completion -> _docker-compose'
zinit snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

zinit wait'1' as'completion' id-as'gh-completion' lucid for \
  atclone'gh completion -s zsh > _gh' atpull'%atclone' zdharma-continuum/null

# Theme
if [[ "$ZSH_THEME" == "p10k" ]]; then
  zinit ice atload'[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' \
    lucid nocd
  zinit load romkatv/powerlevel10k
fi
