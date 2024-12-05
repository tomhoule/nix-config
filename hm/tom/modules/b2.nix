{
  pkgs,
  config,
  ...
}: let
  inherit (pkgs) backblaze-b2;
  backup-to-b2 = pkgs.writeShellScriptBin "backup-to-b2" ''
    set -eux

    ${backblaze-b2}/bin/backblaze-b2 sync ${config.xdg.userDirs.documents} \
        b2://${config.localHome.b2-bucket}/tom/Documents \
        --replace-newer \
        --keep-days 30

    ${backblaze-b2}/bin/backblaze-b2 sync ${config.xdg.userDirs.download} \
        b2://${config.localHome.b2-bucket}/tom/Downloads \
        --replace-newer \
        --keep-days 30

    ${backblaze-b2}/bin/backblaze-b2 sync ${config.xdg.userDirs.pictures} \
        b2://${config.localHome.b2-bucket}/tom/Pictures \
        --replace-newer \
        --keep-days 30

    ${backblaze-b2}/bin/backblaze-b2 sync ${config.xdg.userDirs.videos} \
        b2://${config.localHome.b2-bucket}/tom/Videos \
        --replace-newer \
        --keep-days 30

    ${backblaze-b2}/bin/backblaze-b2 sync ~/src \
        b2://${config.localHome.b2-bucket}/tom/src \
      --exclude-dir-regex '^gh$' \
      --exclude-all-symlinks \
      --replace-newer \
      --keep-days 30
  '';
in {
  home.packages = [
    backblaze-b2
    backup-to-b2
  ];
}
