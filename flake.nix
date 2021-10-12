{
  description = "noch nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        test-vm = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/base.nix
            ./machines/test-vm/config.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tom = ./home.nix;
            }
          ];
          inherit system;
        };

        prisma-desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/base.nix
            ./machines/prisma-desktop/config.nix
             home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
               home-manager.users.tom = ./home.nix;
            }
          ];
          inherit system;
        };
      };
    };
}
