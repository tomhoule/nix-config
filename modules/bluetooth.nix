{ pkgs, ... }:

{
  # Bluetooth
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [ blueberry ];
}
