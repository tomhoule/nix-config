{ pkgs, config, lib, ... }:

let
  inherit (builtins) readFile foldl';
  nvim-spell-en-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl";
    sha256 = "sha256:0w1h9lw2c52is553r8yh5qzyc9dbbraa57w9q0r9v8xn974vvjpy";
  };
  nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
    sha256 = "sha256:0q9vws3fyi33yladjx5n0f6w0gbk76mz2n6fb8bpr24dp419gyxb";
  };
  nvim-spell-de-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl";
    sha256 = "sha256:1ld3hgv1kpdrl4fjc1wwxgk4v74k8lmbkpi1x7dnr19rldz11ivk";
  };

  djot-repo = pkgs.fetchFromGitHub {
    owner = "jgm";
    repo = "djot";
    rev = "0.2.0";
    sha256 = "sha256-5NKISXk7Q6s8Zsb+rWz7PcklX4KfRWfPIUjPGvOdB4Q=";
  };
  djot-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "vim-djot";
    src =  "${djot-repo}/editors/vim";
  };
in
{
  home.file = {
    "${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
    "${config.xdg.configHome}/nvim/spell/en.utf-8.spl".source = nvim-spell-en-utf8-dictionary;
    "${config.xdg.configHome}/nvim/spell/de.utf-8.spl".source = nvim-spell-de-utf8-dictionary;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      vim-dirvish
      vim-eunuch
      vim-gitgutter
      vim-surround
      copilot-vim

      # Theme

      {
        plugin = papercolor-theme;
        config = ''
          let g:PaperColor_Theme_Options = {
            \   'theme': {
            \     'default': {
            \       'transparent_background': 1
            \     }
            \   }
            \ }
          set background=light
          colorscheme PaperColor
        '';
      }

      # Trouble — for better lists
      # https://github.com/folke/trouble.nvim
      trouble-nvim

      # Telescope
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      telescope-nvim

      # Completion
      cmp-buffer
      cmp-nvim-lsp
      cmp-vsnip
      nvim-cmp

      nvim-lspconfig

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-lua
        p.tree-sitter-prisma
        p.tree-sitter-rust
        p.tree-sitter-sql
        p.tree-sitter-graphql
      ]))

      djot-plugin

      # Nix
      vim-nix

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
    extraConfig = foldl' (a: b: a + "luafile ${b}\n") "" [
      ./init.lua
      ./trouble.lua
      ./nvim-lsp-config.lua
      ./treesitter.lua
      ./cmp.lua
      ./telescope.lua
    ];
  };
}
