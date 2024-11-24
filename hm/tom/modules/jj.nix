{
  pkgs,
  userFullName,
  userEmail,
  ...
}: {
  home.packages = [
    pkgs.jujutsu
  ];

  xdg.configFile."jj/config.toml".text = ''
    user.name = "${userFullName}"
    user.email = "${userEmail}"
  '';
}
