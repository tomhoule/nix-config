-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Other options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.inccommand = 'split'
vim.opt.mouse = 'nv'

-- <leader> key mappings
vim.g.mapleader = ' ' -- use space as a leader
vim.g.maplocalleader = 'ç' -- hon hon hon

vim.keymap.set('n', '<leader>w', '<cmd>write<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>Dirvish %<CR>')

-- Shortcuts
vim.keymap.set({'n', 'v'}, 'é', ':')
vim.keymap.set({'n', 'v'}, '!', ':!')
vim.keymap.set({'i', 'n', 'v'}, '<C-l>', '<Esc>')

-- TOML comments
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.toml',
    command = 'setlocal commentstring=#%s',
})

-- nix autoformatting
vim.cmd('autocmd BufRead,BufNewFile *.nix nmap <buffer> <leader>f <cmd>w<ENTER><cmd>!nixpkgs-fmt %<ENTER><ENTER>:e!<ENTER>')
