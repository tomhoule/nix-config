call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'nanotech/jellybeans.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

set termguicolors
colorscheme jellybeans

let mapleader = "»"

nmap <silent> <leader>w :write<ENTER>
nmap <leader>h :nohlsearch<ENTER>
nmap <silent> <leader>f :GFiles<ENTER>
nmap <silent> <leader>rg :Rg<ENTER>
nmap <silent> <leader>gr :Rg<ENTER>
nmap é :
nmap <silent> <leader>d :Dirvish %<ENTER>
imap <C-l> <Esc>
nmap <C-l> <Esc>
vmap <C-l> <Esc>

set smartcase
set autoread

" Indentation
set tabstop=4
set shiftwidth=0
set expandtab
set autoindent

" Replace netrw with dirvish
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
