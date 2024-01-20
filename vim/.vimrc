
set nu rnu
syntax on
inoremap jk <esc>
vnoremap jk <esc>
let g:mapleader=','

set termguicolors
set guicursor=n-v-c:block,o:hor50,i-ci:hor20,r-cr:hor30,sm:block
set wildmenu
" show file n al
set laststatus=2


" https://vim.fandom.com/wiki/Configuring_the_cursor
" Solid underscore
let &t_SI .= "\<Esc>[4 q"

" colorscheme quiet
colorscheme base16-chalk

nnoremap <leader>w :w<cr>

filetype plugin indent on

set tabstop=4 shiftwidth=4 expandtab
