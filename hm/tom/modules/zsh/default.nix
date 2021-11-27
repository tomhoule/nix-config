{ config, pkgs, ... }:

with builtins;

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      size = 20000;
      save = 20000;
      path = "${config.xdg.cacheHome}/zshHistfile";
      share = true;
    };
    initExtraFirst = ''
      autoload -z edit-command-line
      zle -N edit-command-line
    '';
    shellAliases = {
      cat = "bat";
      c = "codium";
      em = "emacs";
      open = "xdg-open";

      # coreutils
      cp = "cp -i";
      grep = "grep --colour";
      ls = "exa";
      mv = "mv -i";

      # git
      add = "git add";
      co = "git checkout";
      commit = "git commit -v";
      rebase = "git rebase";
      reset = "git reset";
      st = "git status";
      db = "git branch -l | fzf | xargs git branch -d";
      cob = "git branch -l | fzf | xargs git checkout";
      coba = "git branch -la | fzf | xargs git checkout";
    };
    initExtra = ''
      source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh

      bindkey '^x^e' edit-command-line # like bash

      prompt='%F{blue}%m%f%B.%b%F{green}%n%f%B.%b%F{yellow}%4~%f %Bλ%b '

      # Only set to nvim if it is not already set
      : ${EDITOR:=nvim}
      export EDITOR

      alias e="''${EDITOR}"

      function tn() {
        DIRNAME=$(basename `pwd` | tr -d '\n')
        tmux new -s $DIRNAME
      }

    '';
  };
}
