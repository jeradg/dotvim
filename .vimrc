execute pathogen#infect()
execute pathogen#helptags()

filetype indent on

autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType js setlocal shiftwidth=2 tabstop=2
autocmd FileType rb setlocal shiftwidth=2 tabstop=2
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2

set tabstop=2

set expandtab

set number

syntax on

" Highlight search
set hls

set background=dark
colorscheme solarized

if has('mac')
        set guifont=PT\ Mono:h18
endif
