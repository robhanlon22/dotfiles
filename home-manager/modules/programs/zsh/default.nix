{
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
  };
}
