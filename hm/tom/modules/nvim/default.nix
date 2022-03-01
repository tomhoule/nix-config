{ pkgs, config, lib, ... }:

let
  inherit (builtins) readFile;
  nvim-spell-en-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl";
    sha256 = "sha256:0w1h9lw2c52is553r8yh5qzyc9dbbraa57w9q0r9v8xn974vvjpy";
  };
  nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
    sha256 = "sha256:0q9vws3fyi33yladjx5n0f6w0gbk76mz2n6fb8bpr24dp419gyxb";
  };
in
{
  home.file = {
    "${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
    "${config.xdg.configHome}/nvim/spell/en.utf-8.spl".source = nvim-spell-en-utf8-dictionary;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
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

      # Telescope
      {
        plugin = telescope-nvim;
        config = ''
          nmap <space><space> <cmd>Telescope find_files<cr>
          nmap <space>rg <cmd>Telescope live_grep<cr>
          nmap <space>gr <cmd>Telescope live_grep<cr>
          nmap <space>b <cmd>Telescope buffers<cr>
        '';
      }

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
