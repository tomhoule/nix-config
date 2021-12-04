{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = (epkgs: with epkgs; [
      evil
      evil-commentary

      # Nice themes to remember if I go graphical.
      # modus-themes
    ]);
    extraConfig = ''
      ; Make some room

      (setq inhibit-startup-message t)
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (menu-bar-mode -1)

      ; These are for graphical emacs only
      ; (set-fringe-mode 10)
      ; (scroll-bar-mode -1)

      ; Visible bell — but why?
      ; (setq visible-bell t)

      ; Disable backup files
      (setq make-backup-files nil)

      (evil-mode 1)
    '';
  };
}
