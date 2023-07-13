{ config, lib, pkgs, ... }:

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

  networking.networkmanager.enable = true;

  services.thermald.enable = lib.mkDefault isx86;

  services.tlp = {
    enable = true;
    # https://linrunner.de/tlp/settings
    settings = {
      PCIE_ASPM_ON_BAT = "powersupersave";

      # https://linrunner.de/tlp/settings/radio.html
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
    };
  };

  powerManagement.enable = true; # How does this mesh with tlp?
}
