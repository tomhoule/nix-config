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

  outputs = { nixpkgs, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";

      mkConfig = ({ systemModules, nixpkgsConfig ? { } }:
        let
          nixpkgsModule = { nixpkgs = { config = nixpkgsConfig; }; };
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

          # https://twitter.com/a_hoverbear/status/1569711910442127361
          specialArgs = { nixPkgsFlake = nixpkgs; };

          inherit system;
        }
      );
    in
    {
      nixosConfigurations = {
        prisma-fw = mkConfig {
          systemModules = [
            ./modules/workstation.nix
            ./modules/laptop.nix
            ./modules/syncthing.nix
            ./modules/tailscale.nix
            ./machines/prisma-fw
            nixos-hardware.nixosModules.framework
          ];
        };

        prisma-desktop = mkConfig {
          systemModules = [
            ./modules/workstation.nix
            ./modules/podman.nix
            ./machines/prisma-desktop/config.nix
            ./modules/tailscale.nix
            ./modules/syncthing.nix
            ./modules/ssh-server.nix
            ./modules/wireshark.nix
            ./modules/dbeaver.nix
          ];

          # This machine needs a proprietary network driver.
          nixpkgsConfig.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "broadcom-sta"
          ];
        };

        xps13 = mkConfig {
          systemModules = [
            ./modules/workstation.nix
            ./modules/laptop.nix
            ./modules/tailscale.nix
            ./modules/syncthing.nix
            ./machines/xps13/config.nix
            nixos-hardware.nixosModules.dell-xps-13-9380
          ];
        };

      };
    };
}
