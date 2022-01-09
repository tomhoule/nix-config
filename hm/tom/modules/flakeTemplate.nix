{ pkgs, ... }:

let
  template = ''
  {
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem ["x86_64-linux"] (system:
    let pkgs = import nixpkgs { inherit system; }; in {
      devShell = pkgs.mkShell {};
    });
  }
  '';
  flakeTemplate = pkgs.writeShellScriptBin "flakeTemplate" ''
    tee << 'TEMPLATE'
      ${template}
    TEMPLATE
  '';
in
{
  home.packages = [ flakeTemplate ];
}
