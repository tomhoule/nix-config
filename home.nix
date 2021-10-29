{ pkgs, localHome }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;

  # Kakoune
  my-kakrc = pkgs.kakouneUtils.buildKakounePlugin {
    name = "tom-kakrc";
    src = ./dotfiles/kak;
  };
  kak = pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [ kak-lsp kak-fzf my-kakrc kakboard ];
  };
in
{
  home = {
    username = "tom";
    sessionVariables = {
      CARGO_HOME = "${homeDirectory}/.cache/cargo";
    };
    inherit homeDirectory;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    # Julia
    julia_16-bin

    # Wayland screenshots (sway)
    slurp
    grim

    # Nix
    nixpkgs-fmt

    # Node...
    nodejs-14_x # LTS

    # & co
    bat
    chromium
    docker-compose
    exa # ls replacement
    firefox
    fzf
    hub # GitHub CLI
    imagemagick
    imv # image viewer
    kak # oune
    mpv
    ranger
    rust-bin.stable.latest.default
    rust-analyzer
    wl-clipboard
    xdg-utils # for xdg-open
    zathura # PDF viewer
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  programs.emacs.enable = true;

  programs.foot = {
    enable = true;
    server = { enable = true; };
    settings = {
      main = {
        font = "IBM Plex Mono:size=${localHome.termFontSize or "7"}";
        letter-spacing = "-0.3";
      };
      colors = {
        alpha = "0.9";
      };
    };
  };

  # Notification daemon
  programs.mako.enable = true;

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
      {
        plugin = fzf-vim;
        config = ''
          nmap <silent> <leader><space> :GFiles<ENTER>
          nmap <silent> <leader>rg :Rg<ENTER>
          nmap <silent> <leader>gr :Rg<ENTER>
          nmap <silent> <leader>b :Buffers<Enter>
        '';
      }
      { plugin = fzf-lsp-nvim; }
      {
        plugin = nvim-lspconfig;
        config = "lua << EOF\n${readFile ./dotfiles/nvim-lsp-config.lua}\nEOF";
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

          nmap <silent> <leader>d :Dirvish %<ENTER>
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
    extraConfig = readFile ./dotfiles/init.vim;
  };

  programs.git = {
    enable = true;
    userName = "Tom Houlé";
    userEmail = homeEmail;
    aliases = {
      st = "status";
      ca = "commit --amend";
      fa = "fetch --all";
      co = "checkout";
      pso = "push --set-upstream origin HEAD";
      pf = "push --force";
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = readFile ./dotfiles/tmux.conf;
    sensibleOnTop = false;
    terminal = "screen-256color";
    historyLimit = 12000;
    keyMode = "vi";
    baseIndex = 1;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      jnoortheen.nix-ide
      matklad.rust-analyzer
      tamasfe.even-better-toml
    ];
    userSettings = {
      editor = {
        fontFamily = "'IBM Plex Mono', 'Fira Code'";
        fontSize = 17;
        formatOnSave = true;
        minimap.enabled = false;
      };
      files = {
        insertFinalNewline = true;
        trimFinalNewlines = true;
        trimTrailingWhitespace = true;
      };
      telemetry.telemetryLevel = "off";
      window = {
        menuBarVisibility = "hidden";
        titleBarStyle = "native";
      };
      workbench.colorTheme = "Dracula";
    };
  };

  programs.zsh = {
    enable = true;
    history = {
      size = 20000;
      save = 20000;
      path = "${homeDirectory}/.histfile";
      share = true;
    };
    shellAliases = {
      cat = "bat";
      c = "codium";
      em = "emacs";
      ls = "exa";
    };
    initExtra = (readFile ./dotfiles/zshrc) + ''
      source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh'';
  };

  xdg = import ./home/xdg.nix { inherit localHome; };
}
