{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.elan];
  home.sessionVariables = {
    ELAN_HOME = "${config.xdg.cacheHome}/elan";
  };
}
