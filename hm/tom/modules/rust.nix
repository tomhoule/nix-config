{ pkgs, config, ... }:

{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.cacheHome}/cargo";
    RUSTUP_HOME = "${config.xdg.cacheHome}/rustup";
  };

  home.packages = with pkgs; [
    rust-analyzer
    rustup
  ];

  programs.zsh.shellAliases = {
    corgi = "cargo";
  };
}
