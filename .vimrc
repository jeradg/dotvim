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

" Unite settings (courtesy of mgraham)

if executable('ag')
" Use ag in unite grep source.
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' ' .
\ ' --ignore ''.yardoc'' --ignore ''html'' --ignore ''doc'' ' .
\ ' --ignore ''vendor'' --ignore ''log'' --ignore ''public/assets'' ' .
\ ' --ignore ''tmp'' '
let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
" if executable('pt')
" Use pt in unite grep source.
" https://github.com/monochromegane/the_platinum_searcher
let g:unite_source_grep_command = 'pt'
let g:unite_source_grep_default_opts = '--nogroup --nocolor'
let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
" Use ack in unite grep source.
let g:unite_source_grep_command = 'ack-grep'
let g:unite_source_grep_default_opts = " --ignore-dir=.yardoc --ignore-dir=html --ignore-dir=doc --ignore-dir=vendor --ignore-dir=log --ignore-dir=public/assets --ignore-dir=tmp"
let g:unite_source_grep_recursive_opt = ''
endif


call unite#filters#sorter_default#use(['sorter_rank'])
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_mru','sorters','sorter_none')
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1

" Use Unite like ctrlp
nnoremap <C-p> :Unite file_rec/async<cr>

" Disable folding in Markdown files
let g:vim_markdown_folding_disabled=1
