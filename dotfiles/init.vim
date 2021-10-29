let mapleader = " " " Use space as a leader

nmap <silent> <leader>w :write<ENTER>
nmap <leader>h :nohlsearch<ENTER>
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

" Indentation
set tabstop=4
set shiftwidth=0
set expandtab
set autoindent

