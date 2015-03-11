" Load Pathogen plugins
execute pathogen#infect()
execute pathogen#helptags()

" Tab settings
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" turn on line numbers
set number

" turn on syntax highlighting
syntax on

" Highlight search
set hls

" Set terminal to screen with 256 colours
" (Fixes colours when using vim with tmux)
set term=screen-256color

""" Filetype-specific settings """
" Haskell
au BufEnter *.hs compiler ghc
au BufEnter *.hs let g:haddock_browser="/usr/bin/google-chrome-stable"
autocmd FileType hs set tabstop=8 softtabstop=4 shiftwidth=4 shiftround

" Theme
set background=dark
colorscheme jellybeans

" Lightline colours
let g:lightline = {'colorscheme': 'jellybeans'}

if has('mac')
        set guifont=PT\ Mono:h18
endif
