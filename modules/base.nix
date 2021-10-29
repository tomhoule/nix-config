{ config, lib, pkgs, ... }:

{
  # System packages.
  environment.systemPackages = with pkgs; [
    ripgrep
    pulseaudio # for utilities like pactl — not the daemon

    # <Added for building rust projects>
    gnumake
    clang
    lld
    openssl
    coreutils
    binutils
    # </Added for building rust>
  ];

  environment.pathsToLink = [ "/share/zsh" ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    EDITOR = "nvim";
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  # TZ & locales.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    fira-code
    font-awesome # required for waybar
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk
    noto-fonts-emoji
    ibm-plex
  ];

  programs = {


    sway = {
      enable = true;
      extraPackages = with pkgs; [
        hicolor-icon-theme # for wofi
        swayidle
        swaylock
        waybar
        wofi
        xorg.xcursorthemes
        xorg.xev
      ];
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };

  # Sound and screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.tom = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "video" # For brillo/brightness control
      "wheel" # Enable ‘sudo’ for the user.
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };

  xdg = {
    mime.enable = true;
    portal = {
      enable = true;
      extraPortals =
        [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    };
  };
}
