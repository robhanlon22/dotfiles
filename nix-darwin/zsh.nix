{
  config,
  enableHomeManager ? false,
  lib,
  pkgs,
  ...
}: let
  zshShared = import ../shared/zsh.nix {inherit lib pkgs;};
  inherit (zshShared) sourceScripts;
in {
  config = lib.mkIf (!enableHomeManager) {
    environment.systemPackages = with pkgs; [
      bat
      ffmpeg
      fzf
      neovim
      starship
    ];

    environment.shellAliases =
      zshShared.mkBaseAliases config.my.dotfiles
      // zshShared.mkUpdateAliases config.my.dotfiles;

    programs.zsh = {
      enableAutosuggestions = true;
      enableCompletion = true;
      promptInit = ''
        eval "$(${lib.getExe pkgs.starship} init zsh)"
      '';
      variables = {
        EDITOR = lib.getExe pkgs.neovim;
        VISUAL = lib.getExe pkgs.neovim;
        GPG_TTY = "$(tty)";
        FAST_WORK_DIR = "$HOME/.config/fsh";
      };

      interactiveShellInit = lib.mkAfter ''
        ${sourceScripts zshShared.pluginsBeforeCompInit}

        export STARSHIP_LOG=error

        bindkey -v
        setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS

        ${sourceScripts zshShared.plugins}
        compstyle zshzoo
        fast-theme -q '${zshShared.catppuccinFastTheme}'

        ${builtins.readFile ../shared/zshrc}
      '';
    };
  };
}
