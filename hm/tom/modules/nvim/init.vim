nmap <silent> <leader>w :write<ENTER>
nmap é :
" Faster way to get to a shell command
nmap ! :!
imap <C-l> <Esc>
nmap <C-l> <Esc>
vmap <C-l> <Esc>

set ignorecase
set smartcase " only goes with ignorecase
set autoread
set inccommand=split
set mouse=nv

" Indentation
set tabstop=4
set shiftwidth=0
set expandtab
set autoindent

" <leader> key mappings
let mapleader = " " " Use space as a leader

nmap <leader>h :nohlsearch<ENTER>
nmap <silent> <leader>d :Dirvish %<ENTER>
nmap <silent> <leader><space> :GFiles<ENTER>
nmap <silent> <leader>rg :Rg<ENTER>
nmap <silent> <leader>gr :Rg<ENTER>
nmap <silent> <leader>b :Buffers<Enter>
