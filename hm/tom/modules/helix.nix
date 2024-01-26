{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_transparent";
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = { command = "nixpkgs-fmt"; };
          auto-format = true;
        }
      ];
    };
  };
  programs.lazygit.enable = true;

  home.packages = [
    pkgs.nil
    pkgs.fishPlugins.z
  ];
}
