{
  description = "ich lieb dich nix du liebst mich nix, da da da";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    rust-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/rust-overlay";
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { overlays = [ rust-overlay.overlay ]; inherit builtins system; };
      homeModules = ({ localHome ? { } }: [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tom =
            import ./home.nix { inherit localHome pkgs; };
        }
      ]);
    in
    {
      nixosConfigurations = {
        prisma-desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/base.nix
            ./modules/docker.nix
            ./machines/prisma-desktop/config.nix
          ] ++ homeModules {
            localHome = import ./machines/prisma-desktop/localHome.nix { };
          };
          inherit system;
        };

        xps13 = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/base.nix
            ./modules/laptop.nix
            ./modules/docker.nix
            ./machines/xps13/config.nix
          ] ++ homeModules {
            localHome = import ./machines/xps13/localHome.nix { };
          };
          inherit system;
        };

      };
    };
}
