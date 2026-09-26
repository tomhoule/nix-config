{
  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # Only for this disposable VM; the physical machine has no default password.
  users.users.tom.initialPassword = "vm";

  services.displayManager.autoLogin = {
    enable = true;
    user = "tom";
  };

  virtualisation.vmVariant.virtualisation = {
    memorySize = 8192;
    cores = 4;
  };

  system.stateVersion = "26.05";
}
