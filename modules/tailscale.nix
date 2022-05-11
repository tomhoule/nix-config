{ config, lib, pkgs, ... }:

{
  networking.firewall.checkReversePath = "loose"; # "strict" can break tailscale
  services.tailscale.enable = true;
}

