
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces
set showmatch           " highlight matching [{()}]
filetype plugin indent on
syntax on
set autoindent

set colorcolumn=100

" don't bell or blink
set noerrorbells
set vb t_vb=

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" js specific stuff
autocmd filetype javascript set sw=2 ts=2 sts=2 expandtab
autocmd filetype json set sw=2 ts=2 sts=2 expandtab

colorscheme delek

set backupdir=~/.vim/backup
set dir=~/.vim/swap
set undodir=~/.vim/undos
set undofile
set bk
syntax off

