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
      path = "${config.home.homeDirectory}/.cache/zshHistfile";
      share = true;
    };
    initExtraFirst = ''
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey '^x^e' edit-command-line # like bash
    '';
    shellAliases = {
      cat = "bat";
      c = "codium";
      em = "emacs";
      ls = "exa";
    };
    initExtra = (readFile ./zshrc) + ''
      source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh
    '';
  };
}
