vim.api.nvim_set_keymap('n', '<leader>li', '<cmd>LspInfo<CR>', { noremap=true, silent=true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- ==============
  -- Buffer options
  -- ==============
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- =========
  -- Mappings
  -- ===%=====
  local opts = { noremap=true, silent=true, buffer=bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>lren', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>lref',  require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', '<leader>lsym',  require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
  vim.keymap.set('n', '<leader>ldsym',  require('telescope.builtin').lsp_document_symbols, opts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>lws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>td', '<cmd>TroubleToggle workspace_diagnostics<CR>', opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
end

-- Debugging
--
-- Uncomment these lines:
-- vim.lsp.set_log_level("debug")
-- vim.env.RA_LOG = "rust_analyzer=info"
--
-- Open the logs:
-- :lua vim.cmd('e'..vim.lsp.get_log_path())
require('lspconfig').rust_analyzer.setup {
    on_attach = on_attach,
    init_options = {
        procMacro = { enable = true },
        cargo = {
            runBuildScripts = true,
        },
    },
}

require('lspconfig').zls.setup {
    on_attach = on_attach,
}

require('lspconfig').tsserver.setup {
    on_attach = on_attach,
}

require('lean').setup{
    abbreviations = { builtin = true },
    lsp = { on_attach = on_attach },
    lsp3 = { on_attach = on_attach },
    mappings = true,
}
