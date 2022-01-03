{ config, lib, pkgs, ... }:

{
  # Screen brightness management.
  hardware.brillo.enable = true;

  # Bluetooth
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.tlp = {
    enable = true;
    # https://linrunner.de/tlp/settings
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # https://linrunner.de/tlp/settings/radio.html
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
    };
  };

  powerManagement.enable = true; # How does this mesh with tlp?
}

