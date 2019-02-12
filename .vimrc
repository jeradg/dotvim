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

" Set terminal to screen with 256 colours
" (Fixes colours when using vim with tmux)
set term=screen-256color
set t_Co=256
set background=dark

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme OceanicNext
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='oceanicnext'

" colorscheme jellybeans
" let g:jellybeans_use_term_italics = 1
" colorscheme solarized

" Store swap files in fixed location, not current directory.
" (Mostly to help with Ember development, as broccoli can
" get confused when .swp files are created/deleted)
set dir=~/.vim/swap//,/var/tmp//,/tmp//,.

" Expanded Todo/Debug highlighting
" (per http://stackoverflow.com/a/6577688/2140241)
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug','\W\zs\(NOTE\|INFO\|IDEA\)')
  endif
endif

" Highlight search
set hls

" consider hyphens to be part of words
set iskeyword +=-

""" Filetype-specific settings """
" Haskell
au BufEnter *.hs compiler ghc
au BufEnter *.hs let g:haddock_browser="/usr/bin/google-chrome-stable"
autocmd FileType hs set tabstop=8 softtabstop=4 shiftwidth=4 shiftround

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

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"

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

" netrw
let g:netrw_banner = 0

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

" RSpec.vim mappings
let g:rspec_command = "call Send_to_Tmux(\"RSpecConsole.run '{spec}'\n\")"
" map <Leader>rt :call RunCurrentSpecFile()<CR>
" map <Leader>rs :call RunNearestSpec()<CR>
" map <Leader>rr :call RunLastSpec()<CR>
" map <Leader>ra :call RunAllSpecs()<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" mac cmd-r -save and run last spec
map <D-r> :w<bar>:call RunLastSpec()<CR>
imap <D-r> <esc>:w<bar>:call RunLastSpec()<CR>

" Highlight words to avoid in tech writing
" =======================================
"
"   obviously, basically, simply, of course, clearly,
"   just, everyone knows, However, So, easy

"   http://css-tricks.com/words-avoid-educational-writing/

"   Code from https://github.com/pengwynn/dotfiles/blob/e090448a71c46fc017acdbd393a5f2f867c6f186/vim/vimrc.symlink#L202-L218

highlight TechWordsToAvoid ctermbg=red ctermfg=white
function MatchTechWordsToAvoid()
  match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfunction
autocmd FileType mkd call MatchTechWordsToAvoid()
autocmd BufWinEnter *.md call MatchTechWordsToAvoid()
autocmd InsertEnter *.md call MatchTechWordsToAvoid()
autocmd InsertLeave *.md call MatchTechWordsToAvoid()
autocmd BufWinLeave *.md call clearmatches()

" Gundo (graphical undo tree)
nnoremap <F5> :GundoToggle<CR>
