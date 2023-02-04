{ pkgs, lib, config, hostName, ... }:

let
  inherit (pkgs) backblaze-b2;
  backup-to-b2 = pkgs.writeShellScriptBin "backup-to-b2" ''
    set -x

    ${backblaze-b2}/bin/backblaze-b2 sync \
      --excludeDirRegex '^tom/.cache$' \
      --excludeDirRegex '^tom/.config/' \
      --excludeDirRegex '^tom/.mozilla$' \
      --excludeDirRegex '^tom/.dropbox$' \
      --excludeDirRegex '^tom/.local/share$' \
      --excludeDirRegex '^tom/.steam$' \
      --excludeDirRegex '^tom/.vscode-oss$' \
      --excludeDirRegex '^tom/src/gh$' \
      --excludeDirRegex '^tom/src/.*/target/debug$' \
      --excludeDirRegex '^tom/src/.*/target/release$' \
      --excludeDirRegex '^tom/src/.*/target/doc$' \
      --excludeDirRegex '^tom/src/.*/zig-cache$' \
      --excludeDirRegex '^tom/src/.*/node_modules$' \
      --excludeDirRegex '^tom/src/.*/.direnv$' \
      --excludeAllSymlinks \
      --keepDays 30 \
      /home \
      b2://${config.localHome.b2-bucket}
  '';
in
{
  home.packages = [
    backblaze-b2
    backup-to-b2
  ];
}
