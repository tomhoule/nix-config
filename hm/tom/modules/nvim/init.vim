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
nmap <silent> <leader><space> <cmd>GFiles<ENTER>
nmap <silent> <leader>rg <cmd>Rg<ENTER>
nmap <silent> <leader>gr <cmd>Rg<ENTER>
nmap <silent> <leader>b <cmd>Buffers<Enter>

" TOML comments
autocmd BufNewFile,BufRead *.toml setlocal commentstring=#%s
