set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'jez/vim-superman'

Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'

Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons' |
            \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'preservim/tagbar'

Plug 'ludovicchabant/vim-gutentags'

Plug 'dense-analysis/ale'
" Plug 'ycm-core/YouCompleteMe'
Plug 'ervandew/supertab'

" Initialize plugin system
call plug#end()

"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif

let g:NERDTreeGitStatusUseNerdFonts = 1

" tagbar
let g:tagbar_autoclose = 0
" automatically open tagbar on supported files
autocmd VimEnter * nested :call tagbar#autoopen(1)

" gutentags
let g:gutentags_project_root = ['.gt_root'] " custom root marker
let g:gutentags_cache_dir = '~/.vim/gutentags' " where to store tag files

" supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1

" man pages
runtime! ftplugin/man.vim
set keywordprg=:Man

" lightline config
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
" lightline config
set noshowmode

let g:lightline = {
\ 'colorscheme': 'nord',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'gitbranch': 'FugitiveHead'
\ }
\ }

let g:indentLine_char = '▏'

let g:lightline.tabline = {
\   'left': [ ['buffers'] ],
\   'right': [ ['close'] ]
\ }

set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
let g:lightline#bufferline#show_number = 1

let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\  'buffers': 'lightline#bufferline#buffers'
\ }

let g:lightline#ale#indicator_checking = 'Linting...'
let g:lightline#ale#indicator_ok = '    OK    '

let g:lightline.component_type = {
\     'linter_checking': 'okay',
\     'linter_warnings': 'warning',
\     'linter_errors': 'error',
\     'linter_ok': 'okay',
\     'buffers': 'tabsel'
\ }

let g:lightline.active = { 'right': [
\              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
\              [ 'void' ],
\              [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype' ]
\              ] }

" ALE settings
"
" Configure fixers
let g:ale_fix_on_save = 0 " Let ALE fix on save
let g:ale_fixers = {
\    '*':       ['remove_trailing_lines', 'trim_whitespace'],
\    'java':    ['remove_trailing_lines', 'trim_whitespace', 'uncrustify', 'google_java_format'],
\    'c':       ['remove_trailing_lines', 'trim_whitespace', 'uncrustify', 'clangtidy'],
\    'haskell': ['remove_trailing_lines', 'trim_whitespace', 'uncrustify', 'stylish_haskell']
\}

" Configure linters
let g:ale_linters = {
\    '*':    ['remove_trailing_lines', 'trim_whitespace'],
\    'java': ['uncrustify', 'javac', 'checkstyle', 'eclipselsp'],
\    'c':    ['uncrustify', 'clangtidy', 'gcc']
\}

let g:ale_c_parse_makefile = 1

" themes & customization stuff
set t_Co=256
colorscheme nord

set cursorline
set cursorcolumn
let g:nord_cursor_line_number_background = 1
let g:nord_italic_comments = 1

" buffer navigation mappings
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

" syntax highlighting
syntax on

" for plugins to load correctly
filetype plugin indent on

" line #s
set number

" hidden buffers
set hidden

" security stuff
set modelines=0

" whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
autocmd FileType java setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab
set autoindent " indent code when going to next line
set smartindent
set expandtab " replace tabs w/ spaces
set noshiftround
match ErrorMsg /\s\+$\|\t/ " highlight illegal whitespace

" show whitespace chars
set list " show whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:¬,nbsp:⎵,trail:•,extends:⟩,precedes:⟨

" ruler column
highlight ColorColumn ctermbg=0
let &colorcolumn="80,".join(range(100,100),",")
" set colorcolumn=120

" Cursor motion
set scrolloff=6
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Formatting
map <leader>q gqip

" Word Processor Mode
func! WordProcessorMode()
 setlocal noexpandtab
 setlocal formatoptions=1
 setlocal wrap
 setlocal linebreak
 setlocal spell spelllang=en_us
endfu

" activate with WP in command mode
com! WP call WordProcessorMode()

" disable bell and set screen flash
set noerrorbells
set visualbell

" character encoding
set encoding=utf-8

" TODO/FIXME line highlighting
augroup myTodo
  autocmd!
  autocmd Syntax * syntax match myTodo /\v\_.<(TODO|FIXME).*/hs=s+1 containedin=.*Comment.*
augroup END

highlight link myTodo Todo

