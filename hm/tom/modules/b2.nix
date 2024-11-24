{
  pkgs,
  config,
  ...
}: let
  inherit (pkgs) backblaze-b2;
  backup-to-b2 = pkgs.writeShellScriptBin "backup-to-b2" ''
    set -x

    ${backblaze-b2}/bin/backblaze-b2 sync \
      --exclude-dir-regex '^tom/.cache$' \
      --exclude-dir-regex '^tom/.config/' \
      --exclude-dir-regex '^tom/.mozilla$' \
      --exclude-dir-regex '^tom/.dropbox$' \
      --exclude-dir-regex '^tom/.grafbase$' \
      --exclude-dir-regex '^tom/.local/share$' \
      --exclude-dir-regex '^tom/.local/state/nvim$' \
      --exclude-dir-regex '^tom/.steam$' \
      --exclude-dir-regex '^tom/.vscode-oss$' \
      --exclude-dir-regex '^tom/src/gh$' \
      --exclude-dir-regex '^tom/src/.*/target/debug$' \
      --exclude-dir-regex '^tom/src/.*/target/release$' \
      --exclude-dir-regex '^tom/src/.*/target/doc$' \
      --exclude-dir-regex '^tom/src/.*/zig-cache$' \
      --exclude-dir-regex '^tom/src/.*/node_modules$' \
      --exclude-dir-regex '^tom/src/.*/lake-packages$' \
      --exclude-dir-regex '^tom/src/.*/.direnv$' \
      --exclude-dir-regex '^tom/tmp$' \
      --exclude-all-symlinks \
      --keep-days 30 \
      /home \
      b2://${config.localHome.b2-bucket}
  '';
in {
  home.packages = [
    backblaze-b2
    backup-to-b2
  ];
}
