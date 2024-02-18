{ pkgs, lib, config, hostName, ... }:

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;

  inherit (builtins) map attrNames readDir;
in
{
  imports =
    let
      moduleImports = map (moduleName: ./. + "/modules/${moduleName}") (attrNames (readDir ./modules));
      perMachineImport = ./. + "/per-machine/${hostName}.nix";
    in
    moduleImports ++ [ perMachineImport ];

  accounts.email.accounts.main = {
    primary = true;
    address = homeEmail;
  };

  home = {
    username = "tom";
    sessionVariables = {
      npm_config_prefix = "${config.xdg.cacheHome}/node_modules";
      npm_cache = "${config.xdg.cacheHome}/npm_cache";
      QT_SCALE_FACTOR = 1.5;
      DO_NOT_TRACK = 1; # https://consoledonottrack.com/
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
  #
  # Link for the release notes:
  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # Nix
    nixpkgs-fmt
    nix-tree

    # & co
    bat
    chromium
    dig # caaan youuuu dig iiiiit?
    eza # ls replacement
    firefox
    imv # image viewer
    jq
    mpv
    ripgrep
    signal-desktop
    unzip
    yt-dlp
    whois
    xdg-utils # for xdg-open
    zathura # PDF viewer
  ];

  home.pointerCursor = {
    package = pkgs.openzone-cursors;
    name = "OpenZone_White";
    size = 64;
    x11.enable = true;
    gtk.enable = true;
  };

  programs.fzf = { enable = true; enableZshIntegration = true; enableFishIntegration = false; };
}
