# Tom's NixOS configuration

It's what it says on the tin.

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

For *partitioning*,

- on ZFS, read the [NixOS on ZFS wiki page](https://nixos.wiki/wiki/ZFS) and follow the instructions there. I tend to use a separate, fully encrypted volume for `/home`.
- or follow the instructions in (this gist)[https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134] for a LVM-on-LUKS

Then, generate the configuration (`configuration.nix` and
`hardware-configuration.nix`) normally. Clone this repository, incorporate the
generated files in `machines/<hostName>`, add a top-level configuration to
`flake.nix`, and finally, use `nixos-install` to install NixOS on the new
machine, as described in the official docs and the `nixos-install` manpage.
