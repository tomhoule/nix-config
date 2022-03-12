{ config, pkgs, ... }:

{
  home.packages = [
    julia-stable-bin # fancy calculator
  ];

  home.sessionVariables.JULIA_DEPOT_PATH = "${config.xdg.cacheHome}/julia";

  programs.neovim.plugins = [{ plugin = pkgs.vimPlugins.julia-vim; }];
}

