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
in
{
  home.file = {
    "${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
    "${config.xdg.configHome}/nvim/spell/en.utf-8.spl".source = nvim-spell-en-utf8-dictionary;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      vim-gitgutter
      vim-surround

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

      # Jump
      { plugin = vim-repeat; }
      { plugin = lightspeed-nvim; }

      # Trouble — for better lists
      # https://github.com/folke/trouble.nvim
      {
        plugin = trouble-nvim;
        config = ''
          lua << EOF
          EOF
        '';
      }

      # Telescope
      { plugin = telescope-fzf-native-nvim; }
      { plugin = telescope-ui-select-nvim; }
      {
        plugin = telescope-nvim;
        config = ''
          lua << EOF
          local trouble = require("trouble")
          require("telescope").setup({
            defaults = {
              mappings = {
                i = { ["<c-t>"] = trouble.open_with_trouble },
                n = { ["<c-t>"] = trouble.open_with_trouble },
              },
            },
            extensions = {
              fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
              }
            }
          })

          -- To get fzf loaded and working with telescope, you need to call
          -- load_extension, somewhere after setup function:
          require('telescope').load_extension('fzf')
          require("telescope").load_extension('ui-select')
          EOF
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
      { plugin = nvim-cmp; config = "luafile ${./cmp.lua}\n"; }

      {
        plugin = (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars));
        config = "luafile ${./treesitter.lua}\n";
      }
      nvim-lspconfig
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
    extraConfig = foldl' (a: b: a + "luafile ${b}\n") "" [ ./init.lua ./trouble.lua ./nvim-lsp-config.lua ];
  };
}
