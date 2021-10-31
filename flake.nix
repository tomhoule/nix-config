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
      pkgs = import nixpkgs { inherit system overlays; };

      mkModules = (systemModules:
        systemModules ++
        [
          ./modules/base.nix
          home-manager.nixosModules.home-manager
          ({ config, ... }: {
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
          })
        ]
      );
    in
    {
      nixosConfigurations = {
        prisma-desktop = nixpkgs.lib.nixosSystem {
          modules = mkModules [
            ./modules/docker.nix
            ./machines/prisma-desktop/config.nix
          ];

          inherit system pkgs;
        };

        xps13 = nixpkgs.lib.nixosSystem {
          modules = mkModules [
            ./modules/laptop.nix
            ./modules/docker.nix
            ./machines/xps13/config.nix
            nixos-hardware.nixosModules.dell-xps-13-9380
          ];

          inherit system pkgs;
        };

      };
    };
}
