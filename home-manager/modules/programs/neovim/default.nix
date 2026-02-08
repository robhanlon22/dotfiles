{
  config,
  lib,
  pkgs,
  localNvimConfig,
  ...
}: let
  mutableConfigPath = toString localNvimConfig;
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Keep Neovim config mutable: this always points at a local out-of-store path.
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink mutableConfigPath;

  # Seed the local mutable config once from the bundled LazyVim starter.
  home.activation.bootstrapLazyvimConfig = lib.hm.dag.entryBefore ["linkGeneration"] ''
    target=${lib.escapeShellArg mutableConfigPath}

    if [ -e "$target" ] && [ ! -d "$target" ]; then
      echo "Expected directory at $target for local Neovim config" >&2
      exit 1
    fi

    if [ ! -e "$target/init.lua" ]; then
      ${pkgs.coreutils}/bin/mkdir -p "$target"
      ${pkgs.coreutils}/bin/cp -R "${./lazyvim}/." "$target"
    fi

    # Ensure mutable local config remains writable even when seeded from
    # read-only Nix store files.
    if [ -d "$target" ]; then
      ${pkgs.coreutils}/bin/chmod -R u+w "$target"
    fi
  '';
}
