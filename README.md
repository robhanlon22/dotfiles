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

## Lightweight by default

`homeManagerConfiguration` now defaults to a lightweight base module:

- `home-manager/lightweight.nix`
- `git`, `ssh`, `zsh`, and `neovim` (LazyVim-style config path)
- no `nixvim` dependency in the default path

If you want a different base, pass `baseHomeModule` to
`lib.${system}.homeManagerConfiguration`.

## Mutable local overrides

When present, these local modules are auto-imported:

- `local/nix-darwin.nix`
- `local/home-manager.nix`

For Neovim, if `local/nvim/` exists, Home Manager symlinks `~/.config/nvim`
to that directory as an out-of-store symlink.

See `local/README.md` for examples.
