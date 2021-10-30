{ lib, ... }:

{
  programs.mako.enable = true; # notification daemon

  xdg.configFile = {
    "sway/config".source = ./config;
    "waybar".source = lib.mkDefault ./waybar;
  };
}
