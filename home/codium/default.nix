{ pkgs }:

{
  enable = true;
  package = pkgs.vscodium;
  extensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    jnoortheen.nix-ide
    matklad.rust-analyzer
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
}
