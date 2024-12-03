{
  lib,
  pkgs,
  ...
}: let
  isx86 = pkgs.stdenv.hostPlatform.isx86;
in {
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Do not wait for NetworkManager to be online on configuration activation.
  systemd.services.NetworkManager-wait-online.enable = false;

  # Not necessary if you have NetworkManager (see docs).
  boot.initrd.systemd.network.wait-online.enable = false;

  services.thermald.enable = lib.mkDefault isx86;
  powerManagement.enable = true;

  # Fingerprint reader
  services.fprintd.enable = false;
}
