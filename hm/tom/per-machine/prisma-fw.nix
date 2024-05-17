{ pkgs, ... }:

{
  localHome = {
    b2-bucket = "xps13-home-backups";
    swayExtraConfig = ''
      output * scale 1
    '';
    termBgAlpha = 0.90;
  };

  home.packages = with pkgs; [ newsboat postgresql ];
}

