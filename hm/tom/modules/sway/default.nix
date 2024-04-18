{ config, pkgs, ... }:

let
  capture-region = pkgs.writeShellScriptBin "capture-region" ''
    wf-recorder --codec=libvpx --audio-codec=libvorbis -f recording.webm -g "$(slurp)" $@
  '';
in
{
  services.mako.enable = true; # notification daemon

  home.packages = with pkgs; [
    capture-region
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
    "sway/config.d/02-per-machine".text = config.localHome.swayExtraConfig;

    "waybar".source = ./waybar;
    "swaylock/config".source = ./swaylock-config;
  };
}
