{ homeEmail }:

{
  enable = true;
  userName = "Tom Houlé";
  userEmail = homeEmail;
  aliases = {
    st = "status";
    ca = "commit --amend";
    fa = "fetch --all";
    co = "checkout";
    pso = "push --set-upstream origin HEAD";
    pf = "push --force";
  };
  extraConfig = {
    init = { defaultBranch = "main"; };
    pull = { rebase = true; };
  };

}
