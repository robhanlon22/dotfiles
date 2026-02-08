{
  config,
  lib,
  pkgs,
  ...
}: let
  zshShared = import ../shared/zsh.nix {inherit lib pkgs;};
  inherit (zshShared) sourceScripts;
in {
  config = {
    environment.systemPackages = with pkgs; [
      bat
      ffmpeg
      fzf
      neovim
      starship
      zoxide
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
        eval "$(${lib.getExe pkgs.zoxide} init zsh)"

        ${sourceScripts zshShared.pluginsBeforeCompInit}
        autoload -U compinit && compinit -C

        export STARSHIP_LOG=error

        bindkey -v
        setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS

        ${sourceScripts zshShared.plugins}
        compstyle zshzoo
        if [[ -t 1 ]]; then
          mkdir -p "''${XDG_CACHE_HOME:-$HOME/.cache}/fsh" >/dev/null 2>&1 || true
          fast-theme -q '${zshShared.catppuccinFastTheme}' >/dev/null 2>&1 || true
        fi

        ${builtins.readFile ../shared/zshrc}
      '';
    };
  };
}
