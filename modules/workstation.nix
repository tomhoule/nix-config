{ config, lib, pkgs, flakeInputs, ... }:

{
  imports = [ flakeInputs.home-manager.nixosModules.home-manager ];

  environment = {
    systemPackages = with pkgs; [
      cachix # the cachix client
      helvum # audio/video piping

      pavucontrol # GUI
      pulseaudio # for utilities like pactl — not the daemon

      usbutils
    ];
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    /*
      We can't use _module.args here because using regular arguments
      to determine which modules to resolve causes infinite loops.
    */
    extraSpecialArgs = { hostName = config.networking.hostName; };

    users.tom.imports = [
      ../hm/tom
    ];
  };

  nix.settings.trusted-users = [ "root" "tom" ];

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        hicolor-icon-theme # for wofi

        # Random utilities
        pciutils

        # Wayland screenshots (sway)
        slurp
        grim

        # Remote desktop
        waypipe

        swayidle
        swaylock
        waybar
        wofi
        wev # xev but for wayland
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
