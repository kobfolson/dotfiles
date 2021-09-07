#
# Zinit, plugins & snippets
#

typeset -A ZINIT
ZINIT_HOME=$HOME/.local/zinit
ZINIT[HOME_DIR]=$ZINIT_HOME
ZINIT[ZCOMPDUMP_PATH]=$XDG_CACHE_HOME/zsh/compdump

if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
  git clone https://github.com/zdharma/zinit.git $ZINIT_HOME/bin
  zcompile $ZINIT_HOME/bin/zinit.zsh
fi

source $ZINIT_HOME/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/compdump"

# Zinit extensions
zinit light-mode for zinit-zsh/z-a-bin-gem-node
zinit light-mode for zinit-zsh/z-a-readurl

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
zinit from'gh-r' lucid for \
  sbin'bin/hub' \
  atclone'mv hub*/* .;
    rm -rf *~*backup(/^F) (#i)install;
    mv etc/hub.zsh* etc/_hub;
    cp share/man/*/*.1 $ZPFX/share/man/man1' \
  atpull'%atclone' @github/hub

zinit from'gh-r' lucid for \
  bpick'*amd64.tar.gz' sbin'**/gh' \
  atclone'cp -vf **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @cli/cli

zinit as'null' wait lucid light-mode for \
  sbin'bin/git-dsf;bin/diff-so-fancy' zdharma/zsh-diff-so-fancy \
  sbin'emojify;fuzzy-emoji' src'fuzzy-emoji-zle.zsh' wfxr/emoji-cli

zinit as'null' from'gh-r' lucid for \
  mv'exa* -> exa' sbin'**/exa' ogham/exa \
  mv'docker* -> docker-compose' sbin'docker-compose' docker/compose \
  mv'jq* -> jq' sbin stedolan/jq \
  mv'shfmt* -> shfmt' sbin @mvdan/sh \
  mv'countdown* -> countdown' sbin antonmedv/countdown \
  sbin junegunn/fzf-bin

zinit from'gh-r' lucid for \
  mv'ghq* -> ghq' sbin'ghq/ghq' x-motemen/ghq \
  mv'pastel* -> pastel' sbin'pastel/pastel' @sharkdp/pastel \
  mv'fd* -> fd' sbin'fd/fd' \
    atclone'cp **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @sharkdp/fd \
  mv'bat* -> bat' sbin'bat/bat' \
    atclone'cp **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @sharkdp/bat

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
  zdharma/null

zinit wait lucid light-mode if'islinux' for \
  id-as'minikube' \
  atclone"curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64" \
  sbin atpull"%atclone" \
  zdharma/null

zinit wait lucid light-mode if'ismac' for \
  id-as'minikube' \
  atclone"curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64" \
  sbin atpull"%atclone" \
  zdharma/null

zinit wait lucid light-mode if'islinux' for \
  id-as'kubectl' \
  atclone"curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o kubectl" \
  sbin atpull"%atclone" \
  zdharma/null

zinit wait lucid light-mode if'ismac' for \
  id-as'kubectl' \
  atclone" curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl -o kubectl" \
  sbin atpull"%atclone" \
  zdharma/null

zinit if'islinux' id-as'terraform' as'readurl|command' extract \
    dlink0'/terraform/%VERSION%/~%.*-(alpha|beta|rc).*%' \
    dlink'/terraform/%VERSION%/terraform_%VERSION%_linux_amd64.zip' \
    for https://releases.hashicorp.com/terraform/

zinit if'ismac' id-as'terraform' as'readurl|command' extract \
    dlink0'/terraform/%VERSION%/~%.*-(alpha|beta|rc).*%' \
    dlink'/terraform/%VERSION%/terraform_%VERSION%_darwin_amd64.zip' \
    for https://releases.hashicorp.com/terraform/

# zinit wait lucid sbin'bin/anyenv' \
#   atload'export ANYENV_ROOT=$HOME/.anyenv; eval "$(anyenv init -)"'
# zinit light anyenv/anyenv

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
  id-as'beet-completion' mv'beet-completion -> _beet'
zinit snippet 'https://github.com/beetbox/beets/blob/master/extra/_beet'

zinit ice wait'1' lucid as'completion' \
  id-as'docker-compose-completion' mv'docker-compose-completion -> _docker-compose'
zinit snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

zinit wait'1' as'completion' id-as'gh-completion' lucid for \
  atclone'gh completion -s zsh > _gh' atpull'%atclone' zdharma/null

# Theme
if [[ "$ZSH_THEME" == "p10k" ]]; then
  zinit ice atload'[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' \
    lucid nocd
  zinit load romkatv/powerlevel10k
fi
