{lib, ...}: {
  xdg = {
    enable = lib.mkDefault true;

    userDirs = {
      enable = lib.mkDefault true;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
    };
  };
}
