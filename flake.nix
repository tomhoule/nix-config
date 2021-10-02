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
            { environment.systemPackages = [ nixpkgs.foot ]; }
          ];
          inherit system;
        };
      };
    };
}
