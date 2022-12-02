{ pkgs, ... }:

{
  localHome = {
    swayInnerGapSize = 10;
    termBgAlpha = 0.95;
    termFontSize = 9.0;
    waybarConfigDir = ../modules/sway/waybar;
  };

  home.packages = with pkgs; [ postgresql mariadb ]; # for the clients
}
