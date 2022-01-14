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
    btop

    tokei

    # Graphics & video
    ffmpeg-full
    imagemagick
  ];
}
