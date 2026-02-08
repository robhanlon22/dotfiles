# Local Mutable Overrides

These files are intentionally loaded by default when present and are gitignored:

- `local/nix-darwin.nix`
- `local/home-manager.nix`
- `local/nvim/`

Use them for day-to-day experimentation without committing changes to your base config.

## `local/nix-darwin.nix`

Example:

```nix
{ pkgs, ... }:
{
  homebrew.casks = [ "visual-studio-code" ];
  environment.systemPackages = [ pkgs.htop ];
}
```

## `local/home-manager.nix`

Example:

```nix
{ pkgs, ... }:
{
  home.packages = [ pkgs.jq pkgs.yq ];
}
```

## Neovim local config

Home Manager symlinks `~/.config/nvim` to a mutable out-of-store directory.
By default this path is `~/.config/nvim-local`, and on first activation (when
`init.lua` is missing), it is bootstrapped from the bundled LazyVim starter.
Edits apply immediately and are decoupled from Nix store rebuilds.

Override the path by passing `localNvimConfig` to
`lib.${system}.homeManagerConfiguration` / `lib.${system}.darwinSystem`.
