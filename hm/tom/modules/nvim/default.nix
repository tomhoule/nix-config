{ pkgs, config, ... }:

let inherit (builtins) readFile; in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      delimitMate
      vim-commentary
      vim-gitgutter
      vim-surround

      # Theme

      {
        plugin = kanagawa-nvim;
        config = ''
          lua << EOF
          require('kanagawa').setup({
              undercurl = true,           -- enable undercurls
              commentStyle = "italic",
              functionStyle = "NONE",
              keywordStyle = "italic",
              statementStyle = "bold",
              typeStyle = "NONE",
              variablebuiltinStyle = "italic",
              specialReturn = true,       -- special highlight for the return keyword
              specialException = true,    -- special highlight for exception handling keywords 
              transparent = true,         -- transparent background
              dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
              colors = {},
              overrides = {},
          })

          -- setup must be called before loading
          vim.cmd("colorscheme kanagawa")
          EOF
        '';
      }

      # Jump
      { plugin = vim-repeat; }
      { plugin = lightspeed-nvim; }

      # Completion
      cmp-buffer
      cmp-nvim-lsp
      cmp-vsnip
      { plugin = nvim-cmp; config = "luafile ${./cmp.lua}"; }

      {
        plugin = (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars));
        config = "luafile ${./treesitter.lua}";
      }
      { plugin = nvim-lspconfig; config = "luafile ${./nvim-lsp-config.lua}"; }
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

      # Nix

      {
        plugin = vim-nix;
        config = "autocmd BufRead,BufNewFile *.nix nmap <buffer> <leader>f <cmd>w<ENTER><cmd>!nixpkgs-fmt %<ENTER><ENTER>:e!<ENTER>";
      }


      # Snippets

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
      vim-vsnip-integ
    ];
    extraConfig = readFile ./init.vim;
  };
}
