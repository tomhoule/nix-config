{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.julia-stable-bin # fancy calculator
  ];

  home.sessionVariables.JULIA_DEPOT_PATH = "${config.xdg.cacheHome}/julia";
}

