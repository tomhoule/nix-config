{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Temporarily
    s3cmd
    awscli

    newsboat
  ];

  localHome = {
    swayInnerGapSize = 4;
    termBgAlpha = 0.90;
    termFontSize = 7;
    waybarConfigDir = ../modules/sway/laptopWaybar;
  };
}

