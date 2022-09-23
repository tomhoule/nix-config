
require("nvim-tree").setup({
  renderer = {
    group_empty = true,
    icons = {
      show = {
        git = false,
        file = false,
        folder = false,
        folder_arrow = false,
      },
    },
  },
})

local nt_api = require("nvim-tree.api")

vim.keymap.set('n', '<leader>d', function() nt_api.tree.toggle(true) end)
