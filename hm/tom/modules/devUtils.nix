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

    # Graphics & video
    ffmpeg-full
    imagemagick
  ];
}
