{ config, lib, pkgs, flakeInputs, ... }:

{
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      ripgrep
    ];
    variables = {
      EDITOR = "hx";
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    # https://jackson.dev/post/nix-reasonable-defaults/
    extraOptions = ''
      connect-timeout = 5
      log-lines = 30
      min-free = 128000000
      max-free = 1000000000
      experimental-features = nix-command flakes
      max-jobs = auto  # Allow building multiple derivations in parallel
      cores = 0 # use all cores

      auto-optimise-store = true
      keep-outputs = true
    '';

    gc = {
      automatic = true;
      dates = "monthly";
    };

    # https://twitter.com/a_hoverbear/status/1569711910442127361
    registry.nixpkgs.flake = flakeInputs.nixpkgs;
  };

  # TZ & locales.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };

  # Use the default systemd NTP mechanism.
  services.timesyncd.enable = true;

  users.users.tom = {
    isNormalUser = true;
    extraGroups = [
      "video" # For brillo/brightness control
      "wheel" # Enable ‘sudo’ for the user.
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
