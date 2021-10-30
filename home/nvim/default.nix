{ pkgs }:

with builtins;

{
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
    {
      plugin = vim-vsnip;
      config = ''
        imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
        smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
      '';
    }
  ];
  extraConfig = readFile ./init.vim;
}
