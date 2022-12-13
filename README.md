# Tom's NixOS configuration

Even with nix making it easier to manage system configuration complexity, I
strive to maintain a streamlined setup. If you want to read this, the
entrypoint should be the `flake.nix` file.

As customary in the nix world, documentation in this repository could use some
improvement. We make extensive use of modules. If you want to understand how
the module mechanism works, please refer to the nixpkgs
[manual](https://nixos.org/manual/nixpkgs/stable/) and [source
code](https://github.com/NixOS/nixpkgs).

## Setting up a new machine

As a basis, follow the [NixOS
manual](https://nixos.org/manual/nixos/stable/#sec-installation).

Regarding partitioning, the NixOS manual way to set up LUKS with ext4 plays
well with `nixos-generate-config`, it is very smooth and easy.

Generate the configuration (`configuration.nix` and
`hardware-configuration.nix`) with `nixos-generate-config`. Clone this
repository, incorporate the generated files in `machines/<hostName>`, add a
top-level configuration to `flake.nix`, and finally, use `nixos-install
--flake` to install NixOS on the new machine, as described in the official docs
and the `nixos-install` manpage.

## Repository organization

The entrypoint is `flake.nix`.

- The `hm` directory contains the home-manager config for my main user.
- The `machines` directory contains machine-specific configuration. In order to
  maximise reuse, I try to keep its contents to a minimum.
- The `modules` directory contains NixOS configuration modules. Each machine
  picks the modules it needs from there. For example, `laptop.nix` is meant for
  laptops only.
