{
  pkgs,
  userFullName,
  userEmail,
  githubHandle,
  ...
}: {
  home.packages = [
    pkgs.jujutsu
  ];

  xdg.configFile."jj/config.toml".text = ''
    user.name = "${userFullName}"
    user.email = "${userEmail}"
    git.push-bookmark-prefix = "${githubHandle}-"
  '';
}
