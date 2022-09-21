{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      cachix # the cachix client
      pulseaudio # for utilities like pactl — not the daemon
      usbutils
    ];

    variables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  fonts = {
    fontconfig.defaultFonts = {
      monospace = [ "Hack" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };

    fonts = with pkgs; [
      dejavu_fonts
      fira-code
      font-awesome # required for waybar
      hack-font
      ibm-plex
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };

  nix.settings.trusted-users = [ "root" "tom" ];

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        hicolor-icon-theme # for wofi

        # Wayland screenshots (sway)
        slurp
        grim

        # Remote desktop
        waypipe

        swayidle
        swaylock
        waybar
        wofi
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
