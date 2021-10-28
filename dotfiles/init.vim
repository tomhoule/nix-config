set termguicolors
colorscheme dracula
let g:dracula_colorterm = 0

let mapleader = " " " Use space as a leader

nmap <silent> <leader>w :write<ENTER>
nmap <leader>h :nohlsearch<ENTER>
nmap <silent> <leader><space> :GFiles<ENTER>
nmap <silent> <leader>rg :Rg<ENTER>
nmap <silent> <leader>gr :Rg<ENTER>
nmap é :
nmap ! :!   " Faster way to get to a shell command
nmap <silent> <leader>d :Dirvish %<ENTER>
imap <C-l> <Esc>
nmap <C-l> <Esc>
vmap <C-l> <Esc>

set ignorecase
set smartcase " only goes with ignorecase
set autoread

" Indentation
set tabstop=4
set shiftwidth=0
set expandtab
set autoindent

