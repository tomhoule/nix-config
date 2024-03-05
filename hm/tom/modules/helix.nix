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
        soft-wrap.enable = true;
        lsp = {
          display-messages = true;
        };
      };
    };
    languages = {
      language-server.gpt = {
        command = "helix-gpt";
      };
      language = [
        {
          name = "nix";
          formatter = { command = "nixpkgs-fmt"; };
          auto-format = true;
          language-servers = [ "nil" "gpt" ];
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" "gpt" ];
        }
      ];
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "helix-gpt" ''
      source ~/local-secrets
      HANDLER=copilot ${pkgs.helix-gpt}/bin/helix-gpt
    '')
  ];
}
