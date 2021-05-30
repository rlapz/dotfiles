colorscheme simple-dark

let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '

syntax enable
filetype plugin indent on

"set autoindent
set colorcolumn=80
set cursorline
"set formatoptions=tcqrn1
set matchpairs+=<:>
set mouse=a
"set number
set hidden
set relativenumber
set scrolloff=5
"set textwidth=80
set tabstop=8
set wrap


" Terminal
set termwinsize=10x0
cabbrev bt bo term
"bel bo term

" NERDTree
"autocmd VimEnter * NERDTree
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <C-t> :NERDTreeToggle<CR>


" imap
imap jj <Esc>

" Plug
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'preservim/nerdtree'
	Plug 'mattn/emmet-vim'
	Plug 'rust-lang/rust.vim'
	"Plug 'stevearc/vim-arduino'
	"Plug 'dart-lang/dart-vim-plugin'
	"Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

