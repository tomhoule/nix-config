{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";

      # Auto-login
      initial_session = {
        command = "sway";
        user = "tom";
      };
    };
  };
}

