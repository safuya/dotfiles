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
Plug 'tpope/vim-repeat'
Plug 'mrk21/yaml-vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe'
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'cespare/vim-toml'

call plug#end()

let mapleader=","

" Indentation
syntax on
filetype indent plugin on
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap <leader>f :FZF<CR>
nnoremap <leader>v :vsp ~/.vimrc<CR>
nnoremap <leader>z :vsp ~/.zshrc<CR>
nnoremap <leader>a :Ag

map <C-n> :NERDTreeToggle<CR>

set number
set t_Co=256
set showmatch
set ruler
set backspace=indent,eol,start
set incsearch
set splitbelow splitright

set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

set background=dark
colorscheme solarized
