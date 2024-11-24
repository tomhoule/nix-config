{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  imports = [
    flakeInputs.home-manager.nixosModules.home-manager
  ];

  environment = {
    systemPackages = with pkgs; [
      cachix # the cachix client

      pavucontrol # GUI
      pulseaudio # for utilities like pactl — not the daemon

      # Random utilities
      pciutils
      usbutils
    ];
  };

  fonts = {
    fontconfig.defaultFonts = {
      monospace = ["Hack"];
      sansSerif = ["Inter"];
      serif = ["Noto Serif"];
    };

    packages = with pkgs; [
      hack-font
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    /*
    We can't use _module.args here because using regular arguments
    to determine which modules to resolve causes infinite loops.
    */
    extraSpecialArgs = {hostName = config.networking.hostName;};

    users.tom.imports = [
      ../hm/tom
    ];
  };

  i18n.inputMethod = {
    enable = false;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-chinese-addons];
  };

  nix.settings = {
    trusted-users = ["root" "tom"];

    substituters = ["https://cosmic.cachix.org/"];
    trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
  };

  # Sound and screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;

  xdg = {
    mime.enable = true;
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}
