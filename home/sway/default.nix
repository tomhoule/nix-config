{ lib, ... }:

{
  xdg.configFile = {
    "sway/config".source = ./config;
    "waybar".source = lib.mkDefault ./waybar;
  };
}
