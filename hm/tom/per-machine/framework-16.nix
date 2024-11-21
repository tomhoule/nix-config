{ lib, pkgs, ... }:

{
  localHome.b2-bucket = "n.a.";
  localHome.termBgAlpha = 1.0;
  programs.helix.settings.theme = lib.mkForce "kanagawa";

  xdg.enable = false;
  xdg.mimeApps.enable = false;
  xdg.userDirs.enable = false;
}
