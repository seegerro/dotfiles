"This .vimrc is not compatible to vi
set nocompatible

"vundle needs filtype plugins off
filetype plugin indent off
syntax off

"set the runtime path for vundle
set rtp+=~/.vim/bundle/Vundle.vim

"start vundle environment
call vundle#begin()

"let Vundle manage Vundle (this is required)
Bundle 'gmarik/Vundle.vim'

"  LIST OF PLUGINS: 
Plugin 'bling/vim-airline'

Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-surround'

Plugin 'MarcWeber/vim-addon-mw-utils'

Plugin 'tomtom/tlib_vim'

Plugin 'tpope/vim-commentary'

Plugin 'flazz/vim-colorschemes'

Plugin 'LateX-Box-Team/LaTeX-Box'

Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'ervandew/supertab'

Plugin 'ntpeters/vim-better-whitespace'

Plugin 'airblade/vim-gitgutter'

Plugin 'w0rp/ale'

"Add plugins before this
call vundle#end()

" " now (after vundle finished) it is save to turn filetype plugins on
filetype plugin indent on
syntax on

"mandatory for airline plugin
set laststatus=2
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

set encoding=utf-8

set showcmd

set nowrap

set expandtab
set shiftwidth=4
set softtabstop=4

"Highlight search restults
set hlsearch
set incsearch
set ignorecase
set smartcase
set smarttab

set autoindent
set smartindent

set number

"Sets a dollar sign to where you are changing
set cpoptions+=$

set title

set wildmenu

"Shows bracket only x seconds
set matchtime=1

"fixes wrong filetype in latex from plaintex to tex
let g:tex_flavor='latex'

"cursor at the the corner
set ruler

"colorscheme
set background=light
set t_Co=256

"colorscheme
colorscheme gruvbox
set background=dark

"Map leader to new key
nnoremap <SPACE> <Nop>
let maplocalleader=" "

"highlight line of cursor
set cursorline

"read file if changed from outside
set autoread


