{
  pkgs,
  config,
  hostName,
  ...
}: let
  homeDirectory = "/home/tom";
  homeDomain = "tomhoule.com";
  homeEmail = "tom@" + homeDomain;

  inherit (builtins) map attrNames readDir;
in {
  imports = let
    moduleImports = map (moduleName: ./. + "/modules/${moduleName}") (attrNames (readDir ./modules));
    perMachineImport = ./. + "/per-machine/${hostName}.nix";
  in
    moduleImports ++ [perMachineImport];

  _module.args = {
    userFullName = "Tom Houlé";
    userEmail = homeEmail;
  };

  accounts.email.accounts.main = {
    primary = true;
    address = homeEmail;
  };

  home = {
    username = "tom";
    language.base = "en_US.UTF-8";
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
  # https://nix-community.github.io/home-manager/release-notes.xhtml
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Nix
    alejandra
    nil
    nix-tree
    nh
    nvd

    cheese

    # & co
    bat
    chromium
    dig # caaan youuuu dig iiiiit?
    eza # ls replacement
    fd # find replacement
    jq
    ripgrep
    signal-desktop
    unzip
    yt-dlp
    whois
    xdg-utils # for xdg-open
    zathura # PDF viewer
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      name = "Fluent";
      package = pkgs.fluent-gtk-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "Adwaita";
      package = pkgs.adwaita-qt;
    };
  };

  # Cursor theme
  home.pointerCursor = {
    package = pkgs.openzone-cursors;
    name = "OpenZone_White";
    size = 64;
    x11.enable = true;
    gtk.enable = true;
  };
}
