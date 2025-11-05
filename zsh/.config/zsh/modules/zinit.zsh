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

# Install binaries from GitHub releases
zinit as'null' from'gh-r' lucid for \
  mv'jq* -> jq' sbin stedolan/jq \
  mv'shfmt* -> shfmt' sbin @mvdan/sh \
  sbin junegunn/fzf-bin \
  mv'eza* -> eza' sbin eza-community/eza \
  mv'gh_*/bin/gh -> gh' sbin'gh' cli/cli \
  mv'glab_*/bin/glab -> glab' sbin'glab' gitlab-org/cli

# Python tools
zinit as'null' from'gh-r' lucid for \
  mv'ruff* -> ruff' sbin astral-sh/ruff \
  bpick'*linux*' mv'uv* -> uv' sbin astral-sh/uv

# DevOps & Cloud tools
zinit as'null' from'gh-r' lucid for \
  bpick'*linux_amd64.zip' mv'terraform -> terraform' sbin hashicorp/terraform \
  bpick'*Linux_x86_64.tar.gz' mv'helm -> helm' sbin helm/helm \
  bpick'*linux/amd64*' mv'kubectl -> kubectl' sbin kubernetes/kubectl \
  bpick'*linux-x86_64.zip' mv'aws/dist/aws -> aws' sbin'aws;aws/dist/aws_completer' aws/aws-cli

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
  OMZT::fishy

# Snippets
zinit ice wait lucid id-as'fzf-keybindings'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

zinit ice wait lucid id-as'fzf-completion'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'

# Completion
zinit ice wait'1' lucid as'completion' \
  id-as'docker-compose-completion' mv'docker-compose-completion -> _docker-compose'
zinit snippet 'https://github.com/docker/compose/blob/v1/contrib/completion/zsh/_docker-compose'

zinit wait'1' as'completion' id-as'gh-completion' lucid for \
  atclone'gh completion -s zsh > _gh' atpull'%atclone' zdharma-continuum/null

zinit wait'1' as'completion' id-as'glab-completion' lucid for \
  atclone'glab completion -s zsh > _glab' atpull'%atclone' zdharma-continuum/null

# DevOps tool completions
zinit wait'1' as'completion' lucid for \
  id-as'kubectl-completion' atclone'kubectl completion zsh > _kubectl' atpull'%atclone' zdharma-continuum/null \
  id-as'helm-completion' atclone'helm completion zsh > _helm' atpull'%atclone' zdharma-continuum/null \
  id-as'terraform-completion' atclone'terraform -install-autocomplete 2>/dev/null || true' zdharma-continuum/null

# AWS CLI completion (sourced directly)
zinit ice wait'1' lucid
zinit snippet 'https://raw.githubusercontent.com/aws/aws-cli/v2/bin/aws_zsh_completer.sh'

# Theme
if [[ "$ZSH_THEME" == "p10k" ]]; then
  zinit ice atload'[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' \
    lucid nocd
  zinit load romkatv/powerlevel10k
fi
