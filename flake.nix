{
  description = "noch nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit builtins system; };
      homeConfig = ({ localHome }: [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tom = import ./home.nix {
            inherit localHome pkgs;
            lib = pkgs.lib;
          };
        }
      ]);
    in {
      nixosConfigurations = {
        test-vm = nixpkgs.lib.nixosSystem {
          modules = [ ./modules/base.nix ./machines/test-vm/config.nix ]
            ++ (homeConfig { });
          inherit system;
        };

        prisma-desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/base.nix
            ./modules/docker.nix
            ./machines/prisma-desktop/config.nix
          ] ++ (homeConfig { });
          inherit system;
        };

        xps13 = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/base.nix
            ./modules/docker.nix
            ./machines/xps13/config.nix
          ] ++ (homeConfig {
            localHome = import ./machines/xps13/localHome.nix { };
          });
          inherit system;
        };

      };
    };
}
