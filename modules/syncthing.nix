{ config, lib, pkgs, ... }:

let
  guiAddress = "127.0.0.1:8384";
  syncthing-ui = pkgs.writeShellScriptBin "syncthing-ui" ''
    xdg-open http://${guiAddress}
  '';
in
{
  environment.systemPackages = [ syncthing-ui ];

  services.syncthing = {
    enable = true;
    user = "tom";
    dataDir = "/home/tom/synced";
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
    inherit guiAddress;
  };
}
