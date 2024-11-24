{
  config,
  userFullName,
  userEmail,
  ...
}: {
  programs.git = {
    enable = true;
    userName = userFullName;
    inherit userEmail;

    aliases = {
      st = "status";
      ca = "commit --amend";
      fa = "fetch --all";
      fo = "fetch origin";
      co = "checkout";
      pso = "push --set-upstream origin HEAD";
      pf = "push --force";
    };
    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = true;};
      merge.conflictstyle = "diff3";
      commit.verbose = true;
      # See `--update-refs` in `man git rebase`.
      rebase.updateRefs = true;
      rerere.enabled = true;
    };
  };
}
