local cmp = require'cmp'

-- Based on the config in https://github.com/hrsh7th/nvim-cmp

vim.api.nvim_set_option("completeopt", "menu,menuone,noselect")

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  preselect  = cmp.PreselectMode.Item,
  confirmation = {
      default_behavior = cmp.ConfirmBehavior.Replace,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, }),
  }),
  sources = cmp.config.sources({
    { name = 'vsnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})

