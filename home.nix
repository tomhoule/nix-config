{ pkgs, localHome }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;
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

    # Rust
    cargo-edit
    rust-bin.stable.latest.default
    rust-analyzer

    # & co
    bat
    chromium
    docker-compose
    exa # ls replacement
    firefox
    hub # GitHub CLI
    imagemagick
    imv # image viewer
    mpv
    ranger
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.kakoune = import ./home/kak { inherit pkgs; };

  # Notification daemon
  programs.mako.enable = true;

  programs.neovim = import ./home/nvim { inherit pkgs; };

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
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      size = 20000;
      save = 20000;
      path = "${homeDirectory}/.histfile";
      share = true;
    };
    initExtraFirst = ''
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey '^x^e' edit-command-line # like bash
    '';
    shellAliases = {
      cat = "bat";
      c = "codium";
      em = "emacs";
      ls = "exa";
    };
    initExtra = (readFile ./dotfiles/zshrc) + ''
      source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh
    '';
  };

  xdg = import ./home/xdg.nix { inherit localHome; };
}
