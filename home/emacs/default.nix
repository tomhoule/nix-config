{ ... }:

{
  programs.emacs.enable = true;

  xdg.configFile."doom".source = ./doom;
  home.sessionPath = ["$HOME/.emacs.d/bin"]; # for doom
}
