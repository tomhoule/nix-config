{ config, lib, pkgs, flakeInputs, ... }:

{
  imports = [
    flakeInputs.home-manager.nixosModules.home-manager
    ./workstation/display-manager.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      cachix # the cachix client
      # helvum # audio/video piping

      pavucontrol # GUI
      pulseaudio # for utilities like pactl — not the daemon

      usbutils
    ];
  };

  fonts = {
    fontconfig.defaultFonts = {
      monospace = [ "Hack" ];
      sansSerif = [ "Inter" ];
      serif = [ "Noto Serif" ];
    };

    packages = with pkgs; [
      font-awesome # required for waybar
      hack-font
      inter
      noto-fonts
      noto-fonts-cjk-sans
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

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-chinese-addons ];
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

  security.polkit.enable = true;

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
