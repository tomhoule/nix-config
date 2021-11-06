{ lib, ... }:

{
  programs.mako.enable = true; # notification daemon

  xdg.configFile = {
    "sway/config".source = ./config;
    "sway/config.d/01-borders-and-gaps".text = lib.mkDefault ''
      default_border pixel 6
      smart_borders on
      smart_gaps on
      gaps inner 10
      gaps outer 0
    '';

    "waybar".source = lib.mkDefault ./waybar;
  };
}
