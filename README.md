# dotfiles

Base flake for my local `nix-darwin` and `home-manager` configuration flakes.

This flake exports two wrapper functions: `lib.${system}.darwinSystem` and
`lib.${system}.homeManagerConfiguration`. These are very purposefully named
after the corresponding functions in `nix-darwin` and `home-manager`. These
functions allow for a flake customized for a particular machine to be built
without having to add any machine configuration in _this_ flake, thus making
this suitable as a base flake for any personal or work machines.

Check out the `examples` directory for example `flake.nix` files for both
`nix-darwin` and `home-manager`. By default, these `flake.nix` files are meant
to live in `~/.config/dotfiles`, and a local clone of this flake is meant to
live in `~/Documents/dotfiles`. These can be changed on a per-machine basis
by overriding the values defined in `my.nix`.

Speaking of the `my.nix`s that are scattered throughout this flake... these
form a custom `lib` hierarchy. Rather than futz with extending `lib`, `my`
lives its own separate life, and is available in all modules via `_module.args`
under the `my` attr. Custom program definitions also use `my` as a prefix by
convention to disambiguate them from programs defined by `home-manager`,
`nixvim`, etc.
