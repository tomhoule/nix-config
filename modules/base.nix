{ config, lib, pkgs, ... }:

{
  # System packages.
  environment.systemPackages = with pkgs; [ ripgrep ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # TZ & locales.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };

  fonts.fonts = with pkgs; [
    fira-code
    font-awesome # required for waybar
    ibm-plex
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    sway = {
      enable = true;
      extraPackages =
        [ pkgs.swaylock pkgs.swayidle pkgs.dmenu pkgs.xorg.xev pkgs.waybar ];
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };

  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
