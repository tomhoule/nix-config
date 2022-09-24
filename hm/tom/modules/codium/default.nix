{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];

    keybindings = [ ];
    userSettings = {
      editor.fontFamily = "Hack, 'Droid Sans Mono', 'monospace', monospace";
      editor.fontLigatures = false;
      editor.fontSize = 12;
      editor.minimap.enabled = false;
      files.trimFinalNewlines = false;
      files.trimTrailingWhitespace = false;
      telemetry.enableCrashReporter = false;
      telemetry.enableTelemetry = true;
      telemetry.telemetryLevel = "off";
      window.menuBarVisibility = "hidden";
      window.zoomLevel = 2;
      workbench.colorTheme = "Quiet Light";
    };
  };
}
