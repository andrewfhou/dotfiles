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
Plug 'ycm-core/YouCompleteMe'

Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/bin/fish

" for plugins to load correctly
filetype plugin indent on

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
" automatically open tagbar in supported files
autocmd FileType * nested :call tagbar#autoopen(0)

" man pages
runtime! ftplugin/man.vim
set keywordprg=:Man

" vimtex
let g:tex_flavor = 'latex'

" YCM
noremap <C-k< <plug>(YCMHover)
let g:ycm_auto_hover = 'CursorHold'

" gutentags
let g:gutentags_project_root = ['.gt_root'] " custom root marker
let g:gutentags_cache_dir = '~/.vim/gutentags' " where to store tag files

" lightline config
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ],
    \              [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
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

" ALE settings
" Configure Fixers
let g:ale_fix_on_save = 0 " Let ALE fix on save
let g:ale_fixers = {
\    '*':       ['remove_trailing_lines', 'trim_whitespace'],
\    'java':    ['remove_trailing_lines', 'trim_whitespace', 'uncrustify', 'google_java_format'],
\    'c':       ['remove_trailing_lines', 'trim_whitespace', 'uncrustify', 'clangtidy', 'gcc'],
\    'haskell': ['remove_trailing_lines', 'trim_whitespace', 'uncrustify', 'stylish_haskell']
\}

" Configure linters
let g:ale_linters = {
\    '*':    ['remove_trailing_lines', 'trim_whitespace'],
\    'java': ['uncrustify', 'javac', 'checkstyle', 'eclipselsp'],
\    'c':    ['uncrustify', 'clangtidy', 'gcc']
\}

" ensure editorconfig works with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" colorscheme
set t_Co=256
colorscheme nord

let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1

" more frequent updates
set updatetime=750

" syntax highlighting
syntax on

" buffer navigaiton mappings
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

" line #s
set number
set relativenumber

" highlight row/column cursor is on
set cursorline
set cursorcolumn

" ruler column
highlight ColorColumn ctermbg=0
let &colorcolumn="80,".join(range(120,120),",")

" cli completion
set wildmenu

" show partial commands
set showcmd

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

" cursor motion
set scrolloff=6
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" move up/down editor lines
nnoremap j gj
nnoremap k gk

" allow hidden buffers
set hidden

" rendering
set ttyfast

" status bar
set laststatus=2

" last line
set showmode
set showcmd

" searching improvements
nnoremap / /\v
vnoremap / /\v
set hlsearch " highlight search results
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" formatting
map <leader>q gqip

" word processor mode
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

" TODO/FIXME line highlighting
augroup myTodo
  autocmd!
  autocmd Syntax * syntax match myTodo /\v\_.<(TODO|FIXME).*/hs=s+1 containedin=.*Comment
augroup END

highlight link myTodo Todo

