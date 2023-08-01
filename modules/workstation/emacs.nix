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
      epkgs.doom-themes
      epkgs.nix-mode
      epkgs.evil
      epkgs.evil-collection
      epkgs.evil-surround
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.rust-mode
      epkgs.which-key
    ]);
  };

  nixpkgs.overlays = [ emacs-overlay ];
}
