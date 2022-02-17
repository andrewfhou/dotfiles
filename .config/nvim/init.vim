set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" Plugins
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'josa42/vim-lightline-coc'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'

Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/bin/fish

" for plugins to load correctly
filetype plugin indent on

" CoC Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
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
" automatically open tagbar in supported files
autocmd FileType * nested :call tagbar#autoopen(0)

" man pages
runtime! ftplugin/man.vim
set keywordprg=:Man

" vimtex
let g:tex_flavor = 'latex'

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
    \              [ 'gitbranch', 'readonly', 'filename', 'modified' ],
    \              [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok'],
    \              [ 'coc_status' ]],
    \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }
call lightline#coc#register()

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
set updatetime=300

" syntax highlighting
syntax on

 " buffer navigation mappings
 map gn :bn<cr>
 map gp :bp<cr>
" map gd :bd<cr>

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
set tabstop=2
set shiftwidth=2

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

" map esc to esc terminal
tnoremap <Esc> <C-\><C-n>

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

