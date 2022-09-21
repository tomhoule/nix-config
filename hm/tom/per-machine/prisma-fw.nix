{ pkgs, ... }:

{
  localHome = {
    swayInnerGapSize = 4;
    swayExtraConfig = ''
      output * scale 1
    '';
    termBgAlpha = 0.90;
    termFontSize = 7.5;
    waybarConfigDir = ../modules/sway/laptopWaybar;
  };
}

