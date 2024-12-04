{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    xserver = {
      enable = false;
      xkb.layout = "fr";
      xkb.variant = "bepo";
    };
  };
}
