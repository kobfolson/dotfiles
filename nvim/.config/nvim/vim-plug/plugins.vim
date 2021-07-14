" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'sheerun/vim-polyglot'                                     " Better Syntax Support
    Plug 'scrooloose/NERDTree'                                      " File Explorer
    Plug 'jiangmiao/auto-pairs'                                     " Auto pairs for '(' '[' '{'
    Plug 'joshdick/onedark.vim'                                     " Onedark Theme
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " Intellisense
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}                 " ranger plugin
    Plug 'mhinz/vim-startify'                                       " startify
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}             " multi-cursor 
    Plug 'ryanoasis/vim-devicons'                                   " devicons
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}          " python support
    Plug 'jremmen/vim-ripgrep'
    Plug 'tpope/vim-fugitive'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'lyuts/vim-rtags'
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'metakirby5/codi.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'vim-test/vim-test'
    Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'dense-analysis/ale'
    Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'hoob3rt/lualine.nvim', {'commit': '82f68c42df9d11e52edb52c86113d0eba5be798d'}
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
