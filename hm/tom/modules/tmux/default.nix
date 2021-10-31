{ ... }:

with builtins;

{
  programs.tmux = {
    enable = true;
    extraConfig = readFile ./tmux.conf;
    sensibleOnTop = false;
    terminal = "screen-256color";
    historyLimit = 12000;
    keyMode = "vi";
    baseIndex = 1;
  };
}
