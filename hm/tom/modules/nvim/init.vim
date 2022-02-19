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

nmap <silent> <leader>w :write<ENTER>
nmap <leader>h <cmd>nohlsearch<ENTER>
nmap <silent> <leader>d <cmd>Dirvish %<ENTER>

" TOML comments
autocmd BufNewFile,BufRead *.toml setlocal commentstring=#%s
