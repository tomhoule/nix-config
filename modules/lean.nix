{
  nix.extraOptions = ''
    max-jobs = auto  # Allow building multiple derivations in parallel
    keep-outputs = true  # Do not garbage-collect build time-only dependencies (e.g. clang)
    # Allow fetching build results from the Lean Cachix cache
    trusted-substituters = https://lean4.cachix.org/
    trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk=
  '';
}
