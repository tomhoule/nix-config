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
        swayExtraConfig = mkOption {
          type = types.lines;
          default = "";
        };

        swayInnerGapSize = mkOption {
          type = types.int;
        };

        termBgAlpha = mkOption {
          type = types.float;
        };

        termFontSize = mkOption {
          type = types.float;
        };

        waybarConfigDir = mkOption {
          type = types.path;
        };
      };
    };
  };
}

