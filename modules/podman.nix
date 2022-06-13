{ config, lib, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  users.users.tom.extraGroups = [
    "podman"
  ];

  home-manager.users.tom = {
    home.packages = [ pkgs.docker-compose ];

    programs.zsh.shellAliases = {
      dc = "docker-compose";
      dcr = "docker-compose run --rm";
    };
  };
}

