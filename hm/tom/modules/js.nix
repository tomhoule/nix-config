{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    nodePackages.typescript-language-server
  ];
}
