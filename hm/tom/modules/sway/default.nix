{ lib, config, pkgs, ... }:

{
  programs.mako.enable = true; # notification daemon

  home.packages = with pkgs; [
    wf-recorder # screen recording that can be combined with slurp
    wl-clipboard
  ];

  xdg.configFile = {
    "sway/config".source = ./config;
    "sway/config.d/01-borders-and-gaps".text = ''
      default_border pixel 6
      smart_borders on
      smart_gaps on
      gaps inner ${builtins.toString config.localHome.swayInnerGapSize}
      gaps outer 0
    '';

    "waybar".source = config.localHome.waybarConfigDir;
  };
}
