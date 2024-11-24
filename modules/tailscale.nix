{
  networking.firewall.checkReversePath = "loose"; # "strict" can break tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
}
