{ pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    coreutils
    gnumake

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
