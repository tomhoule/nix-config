{ pkgs, lib, config, ... }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;
in
{
  imports = [
    ./docker.nix
    ./emacs
    ./foot.nix
    ./kak
    ./nvim
    ./sway
    ./xdg.nix
    ./zsh
  ];

  home = {
    username = "tom";
    sessionVariables = {
      CARGO_HOME = "${homeDirectory}/.cache/cargo";
      npm_config_prefix = "${homeDirectory}/.cache/node_modules";
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

    # Nix
    nixpkgs-fmt

    # Rust
    cargo-edit
    rust-bin.stable.latest.default
    rust-analyzer

    # <Added for building rust projects>
    gnumake
    clang
    lld
    openssl
    coreutils
    binutils
    # </Added for building rust>

    # & co
    bat
    chromium
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

  programs.direnv = import ./direnv.nix;
  programs.fzf = { enable = true; enableZshIntegration = true; };
  programs.git = import ./git.nix { inherit homeEmail; };
  programs.tmux = import ./tmux;
  programs.vscode = import ./codium { inherit pkgs; };
}
