{ pkgs, config, ... }:

{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.cacheHome}/cargo";
  };

  home.packages = with pkgs; [
    cargo-edit
    rustup
  ];

  programs.zsh.shellAliases = {
    corgi = "cargo";
  };
}
