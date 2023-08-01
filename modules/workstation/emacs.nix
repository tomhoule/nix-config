{ config, pkgs, flakeInputs, ... }:

let
  emacs-overlay = import "${flakeInputs.emacs-overlay}/overlays";
  emacsPackage = pkgs.emacs-unstable-pgtk;
  emacsWithPackages = (pkgs.emacsPackagesFor emacsPackage).emacsWithPackages;
in
{
  services.emacs = {
    enable = true;
    package = emacsWithPackages (epkgs: [
      epkgs.corfu
      epkgs.doom-themes
      epkgs.evil
      epkgs.evil-collection
      epkgs.evil-surround
      epkgs.flycheck
      epkgs.nix-mode
      epkgs.rust-mode
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.vertico
      epkgs.which-key
    ]);
  };

  nixpkgs.overlays = [ emacs-overlay ];
}
