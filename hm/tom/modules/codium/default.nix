{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = true;

    keybindings = [ ];
    userSettings = {
      editor.fontFamily = "Hack, 'Droid Sans Mono', 'monospace', monospace";
      editor.fontLigatures = false;
      editor.fontSize = 12;
      editor.minimap.enabled = false;
      files.trimFinalNewlines = true;
      files.trimTrailingWhitespace = true;
      telemetry.enableCrashReporter = false;
      telemetry.enableTelemetry = false;
      telemetry.telemetryLevel = "off";
      window.menuBarVisibility = "hidden";
      window.zoomLevel = 2;
      workbench.colorTheme = "Quiet Light";
    };
  };
}
