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
      co = "checkout";
      pso = "push --set-upstream origin HEAD";
      pf = "push --force";
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      merge.conflictstyle = "diff3";
    };
  };
}
