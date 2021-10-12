{ pkgs, ... }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
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

    # Neovim
    neovim

    # Nix
    nixfmt
    nixpkgs-fmt

    # Node...
    nodejs-14_x # LTS

    # & co
    bat
    firefox
    foot
    exa
    fzf
    hub # GitHub CLI
    rustup # TODO: switch to a direnv-based workflow instead
    rust-analyzer
    zoom-us
    xdg-utils # for xdg-open
    chromium
  ];

  programs.emacs.enable = true;

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
    initExtraFirst = "source ~/.nix-profile/etc/profile.d/nix.sh";
    initExtra = (readFile ./dotfiles/zshrc) + ''
      source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh'';
  };

  xdg = {
    enable = true;
    configFile = {
      "doom".source = ./dotfiles/doom;
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
