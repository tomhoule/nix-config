require('hop').setup();

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>jl', '<cmd>HopLine<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>jw', '<cmd>HopWord<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>jc1', '<cmd>HopChar1<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>jc2', '<cmd>HopChar2<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>jp', '<cmd>HopPattern<CR>', opts)
