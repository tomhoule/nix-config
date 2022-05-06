{ pkgs, ... }:

{
  localHome = {
    swayInnerGapSize = 10;
    termFontSize = 9;
    waybarConfigDir = ../modules/sway/waybar;
  };

  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };

  home.packages = with pkgs; [ postgresql mysql ]; # for the clients
}
