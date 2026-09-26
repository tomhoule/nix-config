{
  description = "ich lieb dich nix du liebst mich nix, da da da";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = flakeInputs @ {
    nixpkgs,
    nixos-hardware,
    ...
  }: let
    system = "x86_64-linux";

    mkConfig = {modules}:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit flakeInputs;
        };

        inherit system modules;
      };
  in {
    nixosConfigurations = {
      framework-13 = mkConfig {
        modules = [
          ./modules/base.nix
          ./modules/workstation.nix
          ./modules/bluetooth.nix
          ./modules/laptop.nix
          ./modules/tailscale.nix
          ./machines/framework-13
          nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
      workstation-vm = mkConfig {
        modules = [
          ./modules/base.nix
          ./modules/workstation.nix
          ./machines/workstation-vm.nix
        ];
      };
    };
  };
}
