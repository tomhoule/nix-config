{ pkgs, ... }:

{
  localHome = {
    b2-bucket = "prisma-desktop";
    swayInnerGapSize = 10;
    termBgAlpha = 0.95;
    waybarConfigDir = ../modules/sway/waybar;
  };

  home.packages = with pkgs; [ postgresql mariadb ]; # for the clients
}
