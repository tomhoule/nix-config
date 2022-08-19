-- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup {
  sync_install = false, -- nix says nø
  auto_install = false, -- nix says nö

  highlight = {
    enable = true, -- false will disable the whole extension

    -- Setting this to true will run `:h syntax` and tree-sitter at the same
    -- time. Set this to `true` if you depend on 'syntax' being enabled (like
    -- for indentation). Using this option may slow down your editor, and you
    -- may see some duplicate highlights. Instead of true it can also be a list
    -- of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}
