{ pkgs, config, ... }:

{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.cacheHome}/cargo";
  };

  home.packages = with pkgs; [
    cargo-edit
    rustPlatform.rust.cargo
    rust-analyzer
  ];

  programs.zsh.shellAliases = {
    corgi = "cargo";
  };
}
