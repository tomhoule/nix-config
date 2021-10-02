{
  description = "noch nix";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  outputs = { self, nixpkgs, home-manager }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        test-vm = nixpkgs.lib.nixosSystem {
          modules = [
            ./test-vm/config.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tom = ./home.nix;
            }
            ({ pkgs, ... }: {
              environment.systemPackages = with pkgs; [
                firefox
                foot
                ripgrep
                vim
                zsh
              ];
              nix = {
                package = pkgs.nixUnstable;
                extraOptions = ''
                  experimental-features = nix-command flakes
                '';
              };

              # Set your time zone.
              time.timeZone = "Europe/Berlin";

              # Select internationalisation properties.
              i18n.defaultLocale = "en_US.UTF-8";
              console = {
                #   font = "Lat2-Terminus16";
                keyMap = "fr-bepo";
              };

              programs = {
                neovim = {
                  enable = true;
                  defaultEditor = true;
                };
              };
              users.users.tom = {
                isNormalUser = true;
                extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
                shell = "${pkgs.zsh}/bin/zsh";
              };
            })
          ];
          inherit system;
        };
      };
    };
}
