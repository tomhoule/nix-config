{
  userFullName,
  userEmail,
  githubHandle,
  ...
}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = userFullName;
      user.email = userEmail;
      git.push-bookmark-prefix = "${githubHandle}-";
    };
  };
}
