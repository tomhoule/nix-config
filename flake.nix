{
  description = "ich lieb dich nix du liebst mich nix, da da da";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "nixpkgs/nixos-24.05";
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
            ./machines/prisma-fw
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };

        prisma-desktop = mkConfig {
          modules = [
            ./modules/base.nix
            ./modules/workstation.nix
            ./modules/bluetooth.nix
            ./modules/docker.nix
            ./machines/prisma-desktop/config.nix
            ./modules/tailscale.nix
            ./modules/ssh-server.nix
            ./modules/wireshark.nix
            ./modules/dbeaver.nix
          ];
        };

        xps13 = mkConfig {
          modules = [
            ./modules/base.nix
            ./modules/workstation.nix
            ./modules/laptop.nix
            ./modules/tailscale.nix
            ./machines/xps13/config.nix
            nixos-hardware.nixosModules.dell-xps-13-9380
          ];
        };
      };
    };
}
