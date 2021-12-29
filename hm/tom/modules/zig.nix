{ pkgs, config, ... }:

{
  programs.neovim.plugins = [
    pkgs.vimPlugins.zig-vim
  ];
}

