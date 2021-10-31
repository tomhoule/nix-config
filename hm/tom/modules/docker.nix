{ pkgs, ... }:

{
  home.packages = [ pkgs.docker-compose ];

  programs.zsh.shellAliases = {
    dc = "docker-compose";
    dcr = "docker-compose run --rm";
    dcup = "docker-compose up";
  };
}
