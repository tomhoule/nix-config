{
  pkgs,
  lib,
  ...
}: {
  programs.zoxide.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/171054
  programs.command-not-found.enable = false;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      function tn
          set --local DIRNAME $(basename $(pwd | tr -d '\n'))
          tmux new -s $DIRNAME
      end

      # No greeting
      set -U fish_greeting
    '';
    shellAliases = {
      cat = "bat";
      ls = "eza";
    };
    shellAbbrs = {
      e = "$EDITOR";
      g = "git";
      dc = "docker compose";
      st = "git status";
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "today" ''date --iso-8601 | tr -d "\n"'')
  ];
}
