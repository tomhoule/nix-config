{ pkgs, ... }:

let
  configFile = ./config.org;
  config = {
    config = configFile;
    package = pkgs.emacsPgtkNativeComp;
    alwaysEnsure = true;
  };
in
{
  services.emacs = {
    install = true;
    package = pkgs.emacsWithPackagesFromUsePackage config;
  };
  home-manager.users.tom.home.file = {
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/config.org".source = configFile;
  };
}