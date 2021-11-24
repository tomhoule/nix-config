{ pkgs, config, ... }:

with builtins;

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = dracula-vim;
        config = ''
          set termguicolors
          colorscheme dracula
          let g:dracula_colorterm = 0
        '';
      }
      { plugin = fzf-vim; }
      { plugin = fzf-lsp-nvim; }

      # Completion
      { plugin = cmp-buffer; }
      { plugin = cmp-nvim-lsp; }
      { plugin = cmp-vsnip; }
      {
        plugin = nvim-cmp;
        config = ''
          " Based on the config in https://github.com/hrsh7th/nvim-cmp
          set completeopt=menu,menuone,noselect

          lua <<EOF
            local cmp = require'cmp'

            cmp.setup({
              snippet = {
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body)
                end,
              },
              mappings = {
                ['<C-SPC>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                }),
              },
              sources = cmp.config.sources({
                { name = 'vsnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
              })
            })
          EOF
        '';
      }

      { plugin = lean-nvim; }
      { plugin = plenary-nvim; } # required by lean-nvim


      {
        plugin = (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars));
        config = ''
          lua <<EOF
            require('nvim-treesitter.configs').setup {
              highlight = {
                enable = true,              -- false will disable the whole extension
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
              },
              incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = '<CR>',
                  scope_incremental = '<CR>',
                  node_incremental = '<TAB>',
                  node_decremental = '<S-TAB>',
                },
              },
            }
          EOF
        '';
      }
      {
        plugin = nvim-lspconfig;
        config = "lua << EOF\n${readFile ./nvim-lsp-config.lua}\nEOF";
      }
      {
        plugin = vim-commentary;
      }
      {
        plugin = vim-dirvish;
        config = ''
          " Replace netrw with dirvish
          let g:loaded_netrwPlugin = 1
          command! -nargs=? -complete=dir Explore Dirvish <args>
          command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
          command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
        '';
      }
      { plugin = vim-gitgutter; }
      {
        plugin = vim-nix;
        config = ''
          autocmd BufRead,BufNewFile *.nix nmap <buffer> <leader>f :w<ENTER>:!nixpkgs-fmt %<ENTER><ENTER>:e!<ENTER>
        '';
      }
      { plugin = vim-surround; }
      { plugin = vim-toml; }
      {
        plugin = vim-vsnip;
        config = ''
          let g:vsnip_snippet_dir = "${config.xdg.configHome}/vsnip-snippets"

          imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
          smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

          imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
          smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
          imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
          smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        '';
      }
      { plugin = vim-vsnip-integ; }
    ];
    extraConfig = readFile ./init.vim;
  };
}
