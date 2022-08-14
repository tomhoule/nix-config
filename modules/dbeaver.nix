{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver
  ];
}


