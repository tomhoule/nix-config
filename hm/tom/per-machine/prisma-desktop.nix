{ pkgs, ... }:

{
  localHome = {
    b2-bucket = "prisma-desktop-home-backups";
    termBgAlpha = 0.95;
    termFontSize = 13.0;
    swayExtraConfig = ''
      output * scale 1.1
    '';
  };

  home.packages = with pkgs; [ postgresql mariadb ]; # for the clients
}
