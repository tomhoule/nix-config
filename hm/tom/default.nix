{ pkgs, lib, config, hostName, ... }:

with builtins;

let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;

  inherit (pkgs) backblaze-b2;
  backup-to-b2 = pkgs.writeShellScriptBin "backup-to-b2" ''
    set -x

    ${backblaze-b2}/bin/backblaze-b2 sync \
      --excludeDirRegex '^tom/.cache$' \
      --excludeDirRegex '^tom/.mozilla/.*/storage$' \
      --excludeRegex '^tom/.mozilla/.*/favicon.sqlite$' \
      --excludeRegex '^tom/.mozilla/.*/webappsstore.sqlite$' \
      --excludeRegex '^tom/.mozilla/.*/places.sqlite$' \
      --excludeAllSymlinks \
      /home \
      b2://${hostName}-home-backups
  '';
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
    # Nix
    nixpkgs-fmt

    # & co
    backblaze-b2
    backup-to-b2
    bat
    chromium
    dig # caaan youuuu dig iiiiit?
    exa # ls replacement
    firefox
    hub # GitHub CLI
    imagemagick
    imv # image viewer
    julia-stable-bin # fancy calculator
    jq
    mpv
    ranger
    unzip
    wl-clipboard
    xdg-utils # for xdg-open
    zathura # PDF viewer
  ];

  programs.fzf = { enable = true; enableZshIntegration = true; };
}
