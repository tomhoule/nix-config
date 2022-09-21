{ pkgs, ... }:

{
  home.packages = with pkgs; [];

  localHome = {
    swayInnerGapSize = 4;
    termBgAlpha = 0.90;
    termFontSize = 7;
    waybarConfigDir = ../modules/sway/laptopWaybar;
  };
}

