{ config, lib, pkgs, ... }:

{
  # System packages.
  environment.systemPackages = with pkgs; [ firefox foot ripgrep vim zsh ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
