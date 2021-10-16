{ pkgs, lib, ... }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";

  # Kakoune
  my-kakrc = pkgs.kakouneUtils.buildKakounePlugin {
    name = "tom-kakrc";
    src = ./dotfiles/kak;
  };
  kak = pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [ kak-lsp kak-fzf my-kakrc ];
  };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tom";
  home.homeDirectory = homeDirectory;

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
    nixfmt
    nixpkgs-fmt

    # Node...
    nodejs-14_x # LTS

    # & co
    bat
    chromium
    docker-compose
    exa
    firefox
    fzf
    hub # GitHub CLI
    imagemagick
    kak
    mpv
    neovim
    ranger
    rust-analyzer
    rustup # TODO: switch to a direnv-based workflow instead
    xdg-utils # for xdg-open
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
  };

  programs.mako.enable = true;

  programs.git = {
    enable = true;
    userName = "Tom Houlé";
    userEmail = "tom@" + homeDomain;
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

  xdg = {
    enable = true;
    configFile = {
      "doom".source = ./dotfiles/doom;
      "foot".source = ./dotfiles/foot;
      "kak-lsp/kak-lsp.toml".source = ./dotfiles/kak-lsp.toml;
      "nvim/init.vim".source = ./dotfiles/init.vim;
      "nvim/autoload/plug.vim".source = fetchurl {
        url =
          "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
        sha256 = "1gpldpykvn9sgykb1ydlwz0zkiyx7y9qhf8zaknc88v1pan8n1jn";
      };
      "sway".source = ./dotfiles/sway;
      "waybar".source = ./dotfiles/waybar;
    };
  };
}
