{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.tom.extraGroups = [
    "docker"
  ];

  home-manager.users.tom = {
    home.packages = [ pkgs.docker-compose ];

    programs.zsh.shellAliases = {
      dc = "docker-compose";
      dcr = "docker-compose run --rm";
    };
  };
}
