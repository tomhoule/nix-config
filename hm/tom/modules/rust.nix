{
  pkgs,
  config,
  ...
}: {
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.cacheHome}/cargo";
    RUSTUP_HOME = "${config.xdg.cacheHome}/rustup";
  };

  programs.fish = {
    shellAliases = {
      corgi = "cargo";
    };
    shellAbbrs = {
      cntr = "cargo nextest run";
    };
  };
}
