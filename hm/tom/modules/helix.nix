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
        }
      ];
    };
  };
  programs.lazygit.enable = true;

  home.packages = [ pkgs.nil ];
  programs.z-lua.enable = true;
  programs.z-lua.enableAliases = true;
}
