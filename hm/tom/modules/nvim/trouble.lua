require("trouble").setup({
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>tq', '<cmd>TroubleToggle quickfix<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tl', '<cmd>TroubleToggle loclist<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tref', '<cmd>TroubleToggle lsp_references<CR>', opts)
