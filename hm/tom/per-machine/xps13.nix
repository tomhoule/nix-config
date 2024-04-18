{ pkgs, ... }:

{
  home.packages = with pkgs; [
    newsboat
  ];

  localHome = {
    swayInnerGapSize = 4;
    termBgAlpha = 0.90;
    termFontSize = 7.0;
  };
}

