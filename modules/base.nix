{ config, lib, pkgs, nixPkgsFlake, ... }:

{
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      ripgrep
    ];
    variables = {
      EDITOR = "nvim";
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      max-jobs = auto  # Allow building multiple derivations in parallel
    '';

    gc = {
      automatic = true;
      dates = "weekly";
    };

    registry.nixpkgs.flake = nixPkgsFlake;
  };

  # TZ & locales.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod.enabled = "uim";

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
