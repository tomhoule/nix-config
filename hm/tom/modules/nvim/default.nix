{ pkgs, config, ... }:

let inherit (builtins) readFile; in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fzf-lsp-nvim
      fzf-vim
      neoformat
      vim-commentary
      vim-gitgutter
      vim-surround

      # Theme

      {
        plugin = dracula-vim;
        config = ''
          set termguicolors
          colorscheme dracula
          hi! Normal ctermbg=none ctermfg=none guifg=none guibg=none
          let g:dracula_colorterm = 0
          let g:dracula_underline = 1
          let g:dracula_bold = 1
          let g:dracula_italic = 1
          let g:dracula_full_special_attrs_support = 1
        '';
      }

      # Jump
      { plugin = hop-nvim; config = "luafile ${./hop.lua}"; }

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
    extraConfig = readFile ./init.vim;
  };
}
