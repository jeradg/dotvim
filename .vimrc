" Autoinstall vim-plug if it isn't present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load vim-plug plugins
call plug#begin('~/.vim/plugged')

" Do I need these ones?
"
" 'Shougo/unite.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'
Plug 'mustache/vim-mustache-handlebars'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/nerdcommenter'
Plug 'chr4/nginx.vim'
Plug 'mhartington/oceanic-next'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
Plug 'elixir-lang/vim-elixir'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-ruby/vim-ruby'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

call plug#end()

" Tab settings
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" turn on line numbers
set number

if has('nvim')
  " For Neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  " Set terminal to xterm with 256 colours and italics
  " (Fixes colours when using vim with tmux)
  " NOTE: Unnecessary in neovim

  set term=xterm-256color
endif

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" turn on syntax highlighting
syntax on

set background=dark

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Italicize comments
highlight Comment cterm=italic

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

colorscheme OceanicNext

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='oceanicnext'

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

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

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"

" netrw
let g:netrw_banner = 0

" Disable folding in Markdown files
let g:vim_markdown_folding_disabled=1

" Tell ctrlp to ignore files from .gitignore
" per https://github.com/kien/ctrlp.vim/issues/174#issuecomment-218866242
if executable('ag')
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
  " and .agignore. Ignores hidden files by default.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
else
  "ctrl+p ignore files in .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

" Highlight words to avoid in tech writing
" =======================================
"
"   obviously, basically, simply, of course, clearly,
"   just, everyone knows, However, So, easy

"   http://css-tricks.com/words-avoid-educational-writing/

"   Code from https://github.com/pengwynn/dotfiles/blob/e090448a71c46fc017acdbd393a5f2f867c6f186/vim/vimrc.symlink#L202-L218
highlight TechWordsToAvoid ctermbg=red ctermfg=white
if !exists("*MatchTechWordsToAvoid")
  function MatchTechWordsToAvoid()
    match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
  endfunction
endif
autocmd FileType mkd call MatchTechWordsToAvoid()
autocmd BufWinEnter *.md call MatchTechWordsToAvoid()
autocmd InsertEnter *.md call MatchTechWordsToAvoid()
autocmd InsertLeave *.md call MatchTechWordsToAvoid()
autocmd BufWinLeave *.md call clearmatches()

" vim-gitgutter
let g:gitgutter_async=0

" coc
call coc#config('coc.preferences', {
      \ "autoTrigger": "always",
      \ "codeLens.enable": 1,
      \ "diagnostic.virtualText": 1,
      \ "eslint.fileTypes": ["javascript", "typescript"],
      \ "maxCompleteItemCount": 10,
      \})

let s:coc_extensions = [
      \ 'coc-dictionary',
      \ 'coc-ember',
      \ 'coc-eslint',
      \ 'coc-json',
      \ 'coc-tag',
      \ 'coc-rls',
      \ 'coc-tsserver',
      \ 'coc-ultisnips',
      \]

for extension in s:coc_extensions
  call coc#add_extension(extension)
endfor
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" supertab
" Make supertab start at the top of the list when tab-completing
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
