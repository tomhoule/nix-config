{ pkgs, config, ... }:

{
  home.sessionVariables =
    let homeDir = config.home.homeDirectory; in
    {
      CARGO_HOME = "${homeDir}/.cache/cargo";
    };

  home.packages = with pkgs; [
    # Rust
    cargo-edit
    rust-bin.stable.latest.default
    rust-analyzer

    # <Added for building rust projects>
    gnumake
    clang
    lld
    openssl
    coreutils
    binutils
    # </Added for building rust projects>
  ];
}
