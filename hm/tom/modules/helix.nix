{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
      };
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

  home.packages = [
    pkgs.nil
  ];
}
