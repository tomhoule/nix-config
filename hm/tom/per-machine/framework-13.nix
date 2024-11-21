{ pkgs, ... }:

{
  localHome = {
    b2-bucket = "xps13-home-backups";
    swayExtraConfig = ''
      output * scale 1
    '';
    termBgAlpha = 0.90;
  };

  home.packages = with pkgs; [ postgresql kanshi firefox ];

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "docked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-3";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
