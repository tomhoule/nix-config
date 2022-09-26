# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 64;
  boot.loader.efi.canTouchEfiVariables = true;

  # YOLO
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];


  # Hardware config
  # https://github.com/NixOS/nixos-hardware/tree/master/framework/12th-gen.html
  services.fwupd.enable = true;

  networking = {
    hostName = "prisma-fw";
    firewall = {
      enable = true;
      checkReversePath = "loose"; # strict mode blocks wireguard
    };
    networkmanager.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
