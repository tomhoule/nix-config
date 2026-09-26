{pkgs, ...}: {
  imports = [
    ./workstation/plasma.nix
  ];

  users.users.tom.packages = [pkgs.firefox];

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
      noto-fonts-color-emoji
    ];
  };

  i18n.inputMethod = {
    enable = false;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-chinese-addons];
  };

  nix.settings = {
    trusted-users = ["root" "tom"];
  };

  # Sound and screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;
  services.avahi.enable = true;
}
