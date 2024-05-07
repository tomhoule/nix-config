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
        # Alias mdx to markdown. We have to repeat the whole file-types array. Issue: https://github.com/helix-editor/helix/issues/6896.
        {
          name = "markdown";
          file-types = [ "md" "markdown" "mkd" "mdwn" "mdown" "markdn" "mdtxt" "mdtext" "workbook" ({ glob = "*PULLREQ_EDITMSG*"; }) "mdx" ];
        }
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
