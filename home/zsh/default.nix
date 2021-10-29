{ pkgs, homeDirectory }:

with builtins;

{
  enable = true;
  defaultKeymap = "emacs";
  enableAutosuggestions = true;
  enableCompletion = true;
  history = {
    size = 20000;
    save = 20000;
    path = "${homeDirectory}/.histfile";
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
}
