{ pkgs, lib, config, hostName, ... }:

let
  inherit (pkgs) backblaze-b2;
  backup-to-b2 = pkgs.writeShellScriptBin "backup-to-b2" ''
    set -x

    ${backblaze-b2}/bin/backblaze-b2 sync \
      --excludeDirRegex '^tom/.cache$' \
      --excludeDirRegex '^tom/.config/chromium$' \
      --excludeDirRegex '^tom/.mozilla$' \
      --excludeDirRegex '^tom/.dropbox$' \
      --excludeDirRegex '^tom/src/gh$' \
      --excludeDirRegex '^tom/src/.*/target/debug$' \
      --excludeDirRegex '^tom/src/.*/target/release$' \
      --excludeDirRegex '^tom/src/.*/zig-cache$' \
      --excludeDirRegex '^tom/src/.*/node_modules$' \
      --excludeDirRegex '^tom/src/.*/.direnv$' \
      --excludeDirRegex '^tom/src/nixpkgs$' \
      --excludeRegex '^tom/.local/share/nvim/shada/main.shada$' \
      --excludeAllSymlinks \
      /home \
      b2://${hostName}-home-backups
  '';
in
{
  home.packages = [
    backblaze-b2
    backup-to-b2
  ];
}
