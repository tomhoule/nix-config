{ config, ... }:

{
  home.packages = [
    # julia_16-bin
  ];

  home.sessionVariables.JULIA_DEPOT_PATH = "${config.xdg.cacheHome}/julia";
}

