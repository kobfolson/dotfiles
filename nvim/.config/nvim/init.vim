"_______________________________________________________________________________________        
" _______________________________________________________________________________________       
"  __/\\\________________/\\\_____/\\\___________________________/\\\_____________________      
"   _\///___/\\/\\\\\\___\///___/\\\\\\\\\\\________/\\\____/\\\_\///_____/\\\\\__/\\\\\___     
"    __/\\\_\/\\\////\\\___/\\\_\////\\\////________\//\\\__/\\\___/\\\__/\\\///\\\\\///\\\_    
"     _\/\\\_\/\\\__\//\\\_\/\\\____\/\\\_____________\//\\\/\\\___\/\\\_\/\\\_\//\\\__\/\\\_   
"      _\/\\\_\/\\\___\/\\\_\/\\\____\/\\\_/\\__________\//\\\\\____\/\\\_\/\\\__\/\\\__\/\\\_  
"       _\/\\\_\/\\\___\/\\\_\/\\\____\//\\\\\____/\\\____\//\\\_____\/\\\_\/\\\__\/\\\__\/\\\_ 
"        _\///__\///____\///__\///______\/////____\///______\///______\///__\///___\///___\///__

if exists('g:vscode')
  "  VSCode 
  source $HOME/.config/nvim/vscode/settings.vim 
else 
  source $HOME/.config/nvim/vim-plug/plugins.vim
  source $HOME/.config/nvim/plug-config/coc.vim
  source $HOME/.config/nvim/plug-config/rnvimr.vim
  source $HOME/.config/nvim/plug-config/start-screen.vim
  source $HOME/.config/nvim/plug-config/vtest.vim
  source $HOME/.config/nvim/plug-config/debugger.vim
  source $HOME/.config/nvim/themes/evil_lualine.vim
  source $HOME/.config/nvim/general/settings.vim
  source $HOME/.config/nvim/keys/mappings.vim
  source $HOME/.config/nvim/themes/bline.vim
endif
