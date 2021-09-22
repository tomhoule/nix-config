[
  (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  }))

  (self: super: {
    nixUnstable =
      super.nixUnstable.override { patches = [ ./unset-is-macho.patch ]; };
  })
]
