{lib, ...}:
with lib; {
  options.localHome = mkOption {
    description = ''
      Tom's custom options to extend the home-manager
      configuration in a more fine-grained way.
    '';

    default = {};

    type = types.submodule {
      options = {
        b2-bucket = mkOption {
          type = types.str;
          description = ''
            The name of the b2 bucket to use for backups.
          '';
        };
      };
    };
  };
}
