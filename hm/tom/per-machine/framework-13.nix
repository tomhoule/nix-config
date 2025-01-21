{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  localHome = {
    b2-bucket = "xps13-home-backups";
  };

  home.packages = with pkgs; [postgresql kanshi firefox nixpkgs-unstable.zed-editor];

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
