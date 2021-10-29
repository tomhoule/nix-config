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
    {
      plugin = nvim-cmp;
      config = ''
        " Based on the config in https://github.com/hrsh7th/nvim-cmp
        set completeopt=menu,menuone,noselect

        lua <<EOF
          local cmp = require'cmp'
          cmp.setup({
            sources = cmp.config.sources({
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
  ];
  extraConfig = readFile ./init.vim;
}
