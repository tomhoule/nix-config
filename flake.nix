{
  description = "ich lieb dich nix du liebst mich nix, da da da";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = flakeInputs@{ nixpkgs, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";

      mkConfig = { modules }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit flakeInputs; };
          inherit system modules;
        };
    in
    {
      nixosConfigurations = {
        prisma-fw = mkConfig {
          modules = [
            ./modules/base.nix
            ./modules/workstation.nix
            ./modules/bluetooth.nix
            ./modules/laptop.nix
            ./modules/docker.nix
            ./modules/tailscale.nix
            ./machines/framework-13
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };
      };
    };
}
