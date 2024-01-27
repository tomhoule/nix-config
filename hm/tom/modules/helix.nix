{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.nil
    ];
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
        lsp = {
          display-messages = true;
        };
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
}
