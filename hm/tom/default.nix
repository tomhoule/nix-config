{ pkgs, lib, config, ... }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;
in
{
  imports = map (moduleName: ./. + "/modules/${moduleName}") (attrNames (readDir ./modules));

  accounts.email.accounts.main = {
    primary = true;
    address = homeEmail;
  };

  home = {
    username = "tom";
    sessionVariables = {
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

  programs.fzf = { enable = true; enableZshIntegration = true; };
}
