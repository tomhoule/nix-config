{
  description = "ich lieb dich nix du liebst mich nix, da da da";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    rust-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/rust-overlay";
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, nixos-hardware }:
    let
      system = "x86_64-linux";
      overlays = [ rust-overlay.overlay ];

      mkConfig = ({ systemModules, nixpkgsConfig ? { } }:
        let
          pkgs = import nixpkgs { inherit system overlays; config = nixpkgsConfig; };
          nixpkgsModule = { nixpkgs = { inherit pkgs; config = nixpkgsConfig; }; };
          homeModule = { config, ... }: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              /*
                We can't use _module.args here because using regular arguments
                to determine which modules to resolve causes infinite loops.
              */
              extraSpecialArgs = { hostName = config.networking.hostName; };
              users.tom = { imports = [ ./hm/tom ]; };
            };
          };
        in
        nixpkgs.lib.nixosSystem {
          modules = systemModules ++
            [
              ./modules/base.nix
              nixpkgsModule
              home-manager.nixosModules.home-manager
              homeModule
            ];

          inherit system pkgs;
        }
      );
    in
    {
      nixosConfigurations = {
        prisma-desktop = mkConfig {
          systemModules = [
            ./modules/docker.nix
            ./modules/lean.nix
            ./machines/prisma-desktop/config.nix
          ];

          # This machine needs a proprietary network driver.
          nixpkgsConfig.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "broadcom-sta"
          ];
        };

        xps13 = mkConfig {
          systemModules = [
            ./modules/laptop.nix
            ./modules/docker.nix
            ./modules/lean.nix
            ./machines/xps13/config.nix
            nixos-hardware.nixosModules.dell-xps-13-9380
          ];
        };

      };
    };
}
