{ config, pkgs, ... }:

{
  home.packages = [
    # julia_16-bin
  ];

  home.sessionVariables.JULIA_DEPOT_PATH = "${config.xdg.cacheHome}/julia";

  programs.neovim.plugins = [{ plugin = pkgs.vimPlugins.julia-vim; }];
}

