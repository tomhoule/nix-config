{ lib, ... }:

with lib;

{
  options.localHome = mkOption {
    description = ''
      Tom's custom options to extend the home-manager
      configuration in a more fine-grained way.
    '';

    default = { };

    type = types.submodule {
      options = {
        swayInnerGapSize = mkOption {
          type = types.int;
        };

        termFontSize = mkOption {
          type = types.int;
        };

        waybarConfigDir = mkOption {
          type = types.path;
        };
      };
    };
  };
}

