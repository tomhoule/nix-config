{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      jnoortheen.nix-ide
      # matklad.rust-analyzer # does not build at this point in time (2021-11-03)
      tamasfe.even-better-toml
    ];
    userSettings = {
      editor = {
        fontFamily = "'IBM Plex Mono', 'Fira Code'";
        fontSize = 17;
        formatOnSave = true;
        minimap.enabled = false;
      };
      files = {
        insertFinalNewline = true;
        trimFinalNewlines = true;
        trimTrailingWhitespace = true;
      };
      telemetry.telemetryLevel = "off";
      window = {
        menuBarVisibility = "hidden";
        titleBarStyle = "native";
      };
      workbench.colorTheme = "Dracula";
    };
  };
}
