{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = (epkgs: with epkgs; [
      agda2-mode
      evil
      evil-commentary

      # Nice themes to remember if I go graphical.
      # modus-themes
    ]);
    extraConfig = ''
      (evil-mode 1)
    '';
  };
}
