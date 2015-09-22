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

" Modified lightline theme from
" https://github.com/itchyny/lightline.vim

" Lightline colours
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
"  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
    \ fname == '__Tagbar__' ? g:lightline.fname :
    \ fname =~ '__Gundo\|NERD_tree' ? '' :
    \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
    \ &ft == 'unite' ? unite#get_status_string() :
    \ &ft == 'vimshell' ? vimshell#get_status_string() :
    \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ ('' != fname ? fname : '[No Name]') .
    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction


function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
"    return strlen(_) ? '⭠ '._ : ''
    return strlen(_) ? _ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

if has('mac')
        set guifont=PT\ Mono:h18
endif

" Unite settings (courtesy of mgraham)
" Unite
let g:unite_source_history_yank_enable = 1
" nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " Close Unite
  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> <C-l>      <Plug>(unite_exit)
  nmap <buffer> <C-l>      <Plug>(unite_exit)
  imap <buffer> <C-c>      <Plug>(unite_exit)
  nmap <buffer> <C-c>      <Plug>(unite_exit)
endfunction

" Unite grep settings (courtesy of mgraham)
" Not really using Unite grep because it's so damn slow
" in the current version of Vim. (Might change in future.)
if executable('ag')
" Use ag in unite grep source.
let g:unite_source_grep_command = 'ag'
" let g:unite_source_grep_default_opts =
" \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
" \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' ' .
" \ ' --ignore ''.yardoc'' --ignore ''html'' --ignore ''doc'' ' .
" \ ' --ignore ''vendor'' --ignore ''log'' --ignore ''public/assets'' ' .
" \ ' --ignore ''node_modules'' --ignore ''.sass-cache'' ' .
" \ ' --ignore ''tmp'' '
let g:unite_source_grep_recursive_opt = ''
" let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
elseif executable('pt')
" if executable('pt')
" Use pt in unite grep source.
" https://github.com/monochromegane/the_platinum_searcher
let g:unite_source_grep_command = 'pt'
let g:unite_source_grep_default_opts = '--nogroup --nocolor'
let g:unite_source_grep_recursive_opt = ''
" Ignore .gitignore'd files with async search
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
" " Ignore .gitignore files
" call unite#custom#source('file_rec/async', 'matchers',
"   \ 'matcher_project_ignore_files')

" Use CommandT like ctrlp
nnoremap <C-p> :CommandT<cr>
let g:CommandTFileScanner = 'git'

" Disable folding in Markdown files
let g:vim_markdown_folding_disabled=1
