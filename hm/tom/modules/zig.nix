{ pkgs, config, ... }:

{
  home.packages = [ pkgs.zls ];

  programs.neovim.plugins = [
    pkgs.vimPlugins.zig-vim
  ];
}

