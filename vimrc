set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Disable vi compatibility for old bugs
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mrk21/yaml-vim'
Plug 'hashivim/vim-terraform'
Plug 'mitsuhiko/vim-jinja'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe'

call plug#end()

" Indentation
syntax on
filetype indent plugin on

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <F8> :FZF<CR>

map <C-n> :NERDTreeToggle<CR>

set number
set t_Co=256
set showmatch
set ruler
set backspace=indent,eol,start
set incsearch
set splitbelow splitright

set laststatus=2
set noshowmode
let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

set background=dark
colorscheme solarized
