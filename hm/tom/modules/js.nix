{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    nodejs_18 # current LTS
    nodePackages.typescript-language-server
  ];
}
