{
  config,
  localNvimConfig,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim".source =
    if builtins.pathExists localNvimConfig
    then config.lib.file.mkOutOfStoreSymlink (toString localNvimConfig)
    else ./lazyvim;
}
