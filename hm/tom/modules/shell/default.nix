{
  programs.atuin = {
    enable = true;
    settings = {
      # Do not execute the command, just insert it on the prompt.
      enter_accept = false;
    };
  };
  programs.fish.enable = true;
  programs.zoxide.enable = true;
}
