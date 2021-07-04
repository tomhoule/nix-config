{ pkgs, ... }:

with builtins;

let
  homeDirectory = "/home/tom";
in
{
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
  home.stateVersion = "21.11";

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
    pkgs.hub
  ];

  programs.alacritty.enable = true;

  programs.git = {
    enable = true;
    userName = "Tom Houlé";
    userEmail = "tom@tomhoule.com";
    aliases = {
      st = "status";
      ca = "commit --amend";
      fa = "fetch --all";
      co = "checkout";
      pso = "push --set-upstream origin HEAD";
      pf = "push --force";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
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
    };
    initExtraFirst = "source ~/.nix-profile/etc/profile.d/nix.sh";
    initExtra = (readFile ./zshrc) + "\nsource ${pkgs.fzf}/share/fzf/key-bindings.zsh";
  };

  xdg = {
    enable = true;
    configFile = {
      nvim-init = {
        source = ./init.vim;
        target = "nvim/init.vim";
      };
      plug-dot-vim = {
        source = fetchurl {
          url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
          sha256 = "1b1ayy2gsnwgfas5rla2y3gjyfsv1cai96p9jbmap4cclpl9ky97";
        };
        target = "nvim/autoload/plug.vim";
      };
    };
  };
}
