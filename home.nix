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

  home.packages = [
    # Coq & OCaml
    pkgs.coq
    pkgs.ocaml
    pkgs.opam

    # Fonts
    pkgs.ibm-plex
    pkgs.fira-code

    # Julia
    pkgs.julia_16-bin

    # Neovim
    pkgs.neovim

    # Nix
    pkgs.nixfmt
    pkgs.nixpkgs-fmt

    # Node...
    pkgs.nodejs-14_x # LTS

    # & co
    pkgs.bat
    pkgs.exa
    pkgs.fzf
    pkgs.hub # GitHub CLI
  ];

  programs.alacritty.enable = true;

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
    extraConfig = readFile ./tmux.conf;
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
      c = "codium";
      em = "emacs";
    };
    initExtraFirst = "source ~/.nix-profile/etc/profile.d/nix.sh";
    initExtra = (readFile ./zshrc) + ''

      source ${pkgs.fzf}/share/fzf/key-bindings.zsh'';
  };

  xdg = {
    enable = true;
    configFile = {
      "doom".source = ./doom;
      "nvim/init.vim".source = ./init.vim;
      "nvim/autoload/plug.vim".source = fetchurl {
        url =
          "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
        sha256 = "1gpldpykvn9sgykb1ydlwz0zkiyx7y9qhf8zaknc88v1pan8n1jn";
      };
    };
  };
}
