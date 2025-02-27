{lib, ...}: {
  programs.zoxide.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/171054
  programs.command-not-found.enable = false;

  programs.fish.enable = lib.mkDefault true;
}
