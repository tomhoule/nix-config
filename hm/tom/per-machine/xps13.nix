{ pkgs, ... }:

{
  home.packages = with pkgs; [ newsboat ];

  localHome = {
    swayInnerGapSize = 4;
    termFontSize = 7;
    waybarConfigDir = ../modules/sway/laptopWaybar;
  };
}

