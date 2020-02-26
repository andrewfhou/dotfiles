set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'jez/vim-superman'
Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/bin/fish

" supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1

" man pages
runtime! ftplugin/man.vim
set keywordprg=:Man

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
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline#ale#indicator_checking = 'Linting...'
let g:lightline#ale#indicator_ok = '    OK    '

let g:lightline.component_type = {
      \     'linter_checking': 'okay',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'okay',
      \ }

let g:lightline.active = { 'right': [
      \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \              [ 'void' ],
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ]
      \              ] }

" ALE settings
" Configure Fixers
let g:ale_fix_on_save = 0 " Let ALE fix on save
let g:ale_fixers = {
\    '*':    ['remove_trailing_lines', 'trim_whitespace'],
\    'java': ['uncrustify', 'javac', 'checkstyle', 'eclipselsp'],
\    'c':    ['uncrustify', 'clangtidy', 'gcc']
\}

" Configure linters
let g:ale_linters = {
\    '*':    ['remove_trailing_lines', 'trim_whitespace'],
\    'java': ['uncrustify', 'javac', 'checkstyle', 'eclipselsp'],
\    'c':    ['uncrustify', 'clangtidy', 'gcc']
\}

" colorscheme
set t_Co=256
colorscheme nord

set cursorline
let g:nord_cursor_line_number_background = 1
let g:nord_italic_comments = 1

" syntax g
syntax on

" for plugins to load correctly
filetype plugin indent on

" line #s
set number

" security stuff
set modelines=0

" whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
match ErrorMsg /\s\+$\|\t/ " highlight illegal whitespace
" whitespace chars
set list " show whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:¬,nbsp:⎵,trail:•,extends:⟩,precedes:⟨
" indentation
set expandtab " replace tabs w/ spaces
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
autocmd FileType java setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab

" ruler column
highlight ColorColumn ctermbg=0
let &colorcolumn="80,".join(range(120,120),",")
" set colorcolumn=120

" Cursor motion
set scrolloff=12
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
set hlsearch " highlight search results
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

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

" disable bell, enable screen flash
set visualbell
set noerrorbells

" set character encoding
set encoding=utf-8
