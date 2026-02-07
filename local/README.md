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

## `local/nvim/`

When this directory exists, Home Manager symlinks `~/.config/nvim` to it as an
out-of-store symlink. Edits apply immediately and are decoupled from Nix store
rebuilds.
