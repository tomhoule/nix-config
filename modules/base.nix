{ config, lib, pkgs, ... }:

{
  # System packages.
  environment.systemPackages = with pkgs; [
    ripgrep
    pulseaudio # for utilities like pactl — not the daemon
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
    ibm-plex
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
  ];

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        hicolor-icon-theme # for wofi

        # Wayland screenshots (sway)
        slurp
        grim

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

  # Use the default systemd NTP mechanism.
  services.timesyncd.enable = true;

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
        [ pkgs.xdg-desktop-portal-gtk ];
      wlr.enable = true;
    };
  };
}
