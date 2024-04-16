{ lib, pkgs, ... }:

let
  isx86 = pkgs.stdenv.hostPlatform.isx86;
in
{
  # Screen brightness management.
  hardware.brillo.enable = true;

  # Bluetooth
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  networking.wireless.iwd.enable = true;

  services.thermald.enable = lib.mkDefault isx86;

  # Fingerprint reader
  services.fprintd.enable = false;

  powerManagement.enable = true; # How does this mesh with tlp?
}
