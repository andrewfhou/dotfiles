set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'ervandew/supertab'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'eljohnso/ale-linter-eastwood' " For CS 240

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/bin/fish

" ALE settings
"
" Configure fixers
let g:ale_fix_on_save = 0 " Let ALE fix on save
let g:ale_fixers = {
\    '*':    ['remove_trailing_lines', 'trim_whitespace'],
\    'java': ['uncrustify', 'javac', 'checkstyle', 'eclipselsp'],
\    'c':    ['eastwood', 'uncrustify', 'clangtidy', 'gcc']
\}

" Configure linters
let g:ale_linters = {
\    '*':    ['remove_trailing_lines', 'trim_whitespace'],
\    'java': ['uncrustify', 'javac', 'checkstyle', 'eclipselsp'],
\    'c':    ['eastwood', 'uncrustify', 'clangtidy', 'gcc']
\}

" supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1

" man pages
runtime! ftplugin/man.vim
set keywordprg=:Man

" themes & customization stuff
set t_Co=256
let g:airline_theme='deus'
colorscheme nord

set cursorline
let g:airline_powerline_fonts = 1
let g:nord_cursor_line_number_background = 1
let g:nord_italic_comments = 1

" syntax highlighting
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
set tabstop=2 " CS240 2-space indent requirement
set shiftwidth=2
set softtabstop=2
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
set hlsearch
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

" disable bell and set screen flash
set noerrorbells
set visualbell

" character encoding
set encoding=utf-8

