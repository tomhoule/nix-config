{pkgs, ...}: {
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

    # Graphics & video
    imagemagick

    # Network
    dig # caaan youuuu dig iiiiit?
    whois
    xh # http client
  ];
}
