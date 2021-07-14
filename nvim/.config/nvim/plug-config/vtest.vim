" vim-test
if has('nvim')
  let test#strategy='neovim'
else
  let test#strategy='vimterminal'
endif

let test#python#runner='pytest'

" vim-ultest
let test#python#pytest#options = "--color=yes"

let test#javascript#jest#options = "--color=always"

