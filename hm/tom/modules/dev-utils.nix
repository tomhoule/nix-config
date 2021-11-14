{ pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    coreutils
    gnumake
    lld
  ];
}


