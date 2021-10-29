{ localHome }:

{
  enable = true;

  configFile = {
    "doom".source = ../dotfiles/doom;
    "kak-lsp/kak-lsp.toml".source = ../dotfiles/kak/kak-lsp.toml;
    "sway".source = ../dotfiles/sway;
    "waybar".source = localHome.waybarDir or ../dotfiles/waybar;
  };

  mimeApps = {
    enable = true;
    defaultApplications =
      let defaultBrowser = "firefox.desktop";
      in
      {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];

        "x-scheme-handler/http" = [ defaultBrowser ];
        "x-scheme-handler/https" = [ defaultBrowser ];
        "x-scheme-handler/chrome" = [ defaultBrowser ];
        "text/html" = [ defaultBrowser ];
        "application/x-extension-htm" = [ defaultBrowser ];
        "application/x-extension-html" = [ defaultBrowser ];
        "application/x-extension-shtml" = [ defaultBrowser ];
        "application/xhtml+xml" = [ defaultBrowser ];
        "application/x-extension-xhtml" = [ defaultBrowser ];
        "application/x-extension-xht" = [ defaultBrowser ];
      };
  };

  userDirs = {
    enable = true;
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
  };
}
