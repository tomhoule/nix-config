{ pkgs, ... }:

{
  home.packages = with pkgs; [
    newsboat
  ];

  localHome = {
    termBgAlpha = 0.90;
    termFontSize = 7.0;
  };
}

