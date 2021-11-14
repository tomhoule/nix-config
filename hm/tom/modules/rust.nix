{ pkgs, config, ... }:

{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.cacheHome}/cargo";
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
