let
  zshEnabled = {enableZshIntegration = true;};
in {
  imports = [./nix.nix ./init-extra.nix];

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      shellAliases = {
        ls = "ls --color";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "cursor" "root" "line"];
      };
    };

    direnv = zshEnabled;
    fzf = zshEnabled;
    kitty.shellIntegration = zshEnabled;
    starship = zshEnabled;
    zoxide = zshEnabled;
  };
}
