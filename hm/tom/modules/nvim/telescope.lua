local trouble = require("trouble")
require("telescope").setup({
defaults = {
  mappings = {
    i = { ["<c-t>"] = trouble.open_with_trouble },
    n = { ["<c-t>"] = trouble.open_with_trouble },
  },
},
extensions = {
  fzf = {
    fuzzy = true,                    -- false will only do exact matching
    override_generic_sorter = true,  -- override the generic sorter
    override_file_sorter = true,     -- override the file sorter
    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  }
}
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require("telescope").load_extension('ui-select')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space><space>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<space>rg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<space>gr', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>')
