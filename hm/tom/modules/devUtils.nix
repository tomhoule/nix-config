{ pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    coreutils
    gnumake
    lld

    hyperfine

    iotop
    htop

    # Graphics & video
    ffmpeg-full
    imagemagick
  ];
}