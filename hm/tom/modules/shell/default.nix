{
  programs.atuin = {
    enable = true;
    settings = {
      # Do not execute the command, just insert it on the prompt.
      enter_accept = false;
    };
  };

  programs.starship.enable = true;
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
      cat = "bat --theme gruvbox-light";
    };
    shellAbbrs = {
      e = "$EDITOR";
      g = "git";
      dc = "docker-compose";
      st = "git status";
    };
  };
}
