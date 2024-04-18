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

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  services.thermald.enable = lib.mkDefault isx86;

  # Fingerprint reader
  services.fprintd.enable = false;

  powerManagement.enable = true; # How does this mesh with tlp?
  services.tlp = {
    enable = true;
    settings = {
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";
      # https://linrunner.de/tlp/settings/platform.html
      PLATFORM_PROFILE_ON_BAT = "balance";
    };
  };
}
