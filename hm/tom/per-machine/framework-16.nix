{
  lib,
  pkgs,
  ...
}: {
  localHome.b2-bucket = "n.a.";
  programs.helix.settings.theme = lib.mkForce "kanagawa";

  xdg.enable = false;
  xdg.userDirs.enable = false;

  # Only necessary as long as this machine isn't on nixos
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };
}
