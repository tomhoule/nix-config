{ pkgs, ... }:

{
  localHome = {
    b2-bucket = "xps13-home-backups";
    swayInnerGapSize = 4;
    swayExtraConfig = ''
      output * scale 1
    '';
    termBgAlpha = 0.90;
    termFontSize = 7.5;
    waybarConfigDir = ../modules/sway/laptopWaybar;
  };

  home.packages = with pkgs; [ newsboat signal-desktop ];
}

