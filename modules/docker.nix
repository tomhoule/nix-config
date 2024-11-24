{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.tom.extraGroups = [
    "docker"
  ];

  home-manager.users.tom = {
    home.packages = [pkgs.docker-compose];
  };
}
