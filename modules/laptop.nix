{
  lib,
  pkgs,
  ...
}: let
  isx86 = pkgs.stdenv.hostPlatform.isx86;
in {
  # Screen brightness management.
  hardware.brillo.enable = true;

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  services.thermald.enable = lib.mkDefault isx86;
  powerManagement.enable = true;

  # Fingerprint reader
  services.fprintd.enable = false;
}
