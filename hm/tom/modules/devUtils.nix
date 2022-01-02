{ pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    coreutils
    gnumake
    lld

    strace

    hyperfine

    iotop
    htop

    # Graphics & video
    ffmpeg-full
    imagemagick
  ];
}
