{ pkgs, ... }:

{
  localHome = {
    b2-bucket = "prisma-desktop";
    swayInnerGapSize = 4;
    termBgAlpha = 0.95;
  };

  home.packages = with pkgs; [ postgresql mariadb ]; # for the clients
}
