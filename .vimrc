colorscheme simple-dark

let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep='|'

"set number
set relativenumber
set autoindent
"set hidden
set textwidth=80
set formatoptions=tcqrn1
set tabstop=8
set colorcolumn=80
set mouse=a
set scrolloff=5
"set wrap
set matchpairs+=<:>

" NERDTree
"autocmd VimEnter * NERDTree
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && \
"\exists('b:NERDTree') && b:NERDTree.isTabTree() |
    "\ quit | endif
nnoremap <C-t> :NERDTreeToggle<CR>


" imap
imap jj <Esc>

" Plug
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'preservim/nerdtree'
	"Plug 'stevearc/vim-arduino'
	"Plug 'dart-lang/dart-vim-plugin'
	"Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

