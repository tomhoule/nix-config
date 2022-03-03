{ config, lib, pkgs, ... }:

let
  groupName = "syncthing";
  guiAddress = "127.0.0.1:8384";
  syncthing-ui = pkgs.writeShellScriptBin "syncthing-ui" ''
    xdg-open http://${guiAddress}
  '';
in
{
  environment.systemPackages = [ syncthing-ui ];
  users.users.tom.extraGroups = [ groupName ];

  services.syncthing = {
    enable = true;
    group = groupName;
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
    inherit guiAddress;
  };
}
