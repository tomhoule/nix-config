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

    sshfs

    tokei

    # Graphics & video
    ffmpeg-full
    imagemagick
  ];
}
