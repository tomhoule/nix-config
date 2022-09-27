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
      # https://linrunner.de/tlp/settings/battery.html
      START_CHARGE_THRESH_BAT0 = 55;
      STOP_CHARGE_THRESH_BAT0 = 60;
      RESTORE_THRESHOLDS_ON_BAT = 1;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # https://linrunner.de/tlp/settings/radio.html
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
    };
  };

  powerManagement.enable = true; # How does this mesh with tlp?
}

