{ config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Tom Houlé";
    userEmail = config.accounts.email.accounts.main.address;
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
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      merge.conflictstyle = "diff3";
      commit.verbose = true;
      # See `--update-refs` in `man git rebase`.
      rebase.updateRefs = true;
    };
  };
}
