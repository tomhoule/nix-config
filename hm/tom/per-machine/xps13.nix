{ ... }:

{
  xdg.configFile = {
    "waybar".source = ../modules/sway/laptopWaybar;
    "sway/config.d/01-borders-and-gaps".text = ''
      default_border pixel 6
      smart_borders on
      smart_gaps on
      gaps inner 6
      gaps outer 0
    '';
  };
}

