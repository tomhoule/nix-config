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

    linuxPackages.perf

    sshfs

    tokei

    # Graphics & video
    imagemagick

    # Network
    dig # caaan youuuu dig iiiiit?
    whois
  ];
}
