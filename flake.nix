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
      pkgs = import nixpkgs { inherit builtins system overlays; };

      mkModules = (systemModules: homeModules:
        systemModules ++
        [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tom = with pkgs.lib; {
              imports =
                [{
                  options.localHome = mkOption {
                    description = ''
                      Tom's custom options to extend the home-manager
                      configuration in a more fine-grained way.
                    '';

                    default = {};

                    type = types.submodule {
                      options = {
                        termFontSize = mkOption {
                          type = types.str;
                          default = "7";
                        };
                        waybarDir = mkOption {
                          type = types.path;
                          default = ./home/waybar;
                        };
                      };
                    };
                  };
                }]
                ++
                homeModules
              ;
            };
          }
        ]
      );
    in
    {
      nixosConfigurations = {
        prisma-desktop = nixpkgs.lib.nixosSystem {
          modules = mkModules
            [
              ./modules/base.nix
              ./modules/docker.nix
              ./machines/prisma-desktop/config.nix
            ]
            [
              ./machines/prisma-desktop/localHome.nix
              ./home
            ];

          inherit system pkgs;
        };

        xps13 = nixpkgs.lib.nixosSystem {
          modules = mkModules
            [
              ./modules/base.nix
              ./modules/laptop.nix
              ./modules/docker.nix
              ./machines/xps13/config.nix
              nixos-hardware.nixosModules.dell-xps-13-9380
            ]
            [
              ./machines/xps13/localHome.nix
              ./home
            ];

          inherit system pkgs;
        };

      };
    };
}
