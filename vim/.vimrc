set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required 
syntax on

"set clipboard=unnamedplus

"color theme
set background=dark
colorscheme darkblue

" Status bar.
set laststatus=2

"LightLine color theme
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

set encoding=utf-8

set showcmd
set showmode

set nowrap


"Indentation
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

set mouse=a


"Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set smarttab

set autoindent
set smartindent

set number

set cpoptions+=$

set title
set wildmenu
set wildmode=list:longest

set matchtime=1

set ruler

"Map leader to new key
nnoremap <SPACE> <Nop>
let maplocalleader=" "

"highlight line of cursor
"set cursorline

"read file if changed from outside
set autoread

set history=500

"No error bell
"
set belloff=all


"change cursor line
"set termguicolors  
let &t_SI = "\e[6 q"  " SI = Start Insert mode (beam)
let &t_EI = "\e[2 q"  " EI = End Insert mode (block)

"Remove delay for switching modes
set ttimeout
set ttimeoutlen=1
set ttyfast

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

