{pkgs, ...}: {
  programs.nixvim.extraPlugins = [
    pkgs.vimPlugins.nvim-paredit
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-paredit-fennel";
      src = pkgs.fetchFromGitHub {
        owner = "julienvincent";
        repo = "nvim-paredit-fennel";
        rev = "master";
        hash = "sha256-7ClT9HMapWxn0rr9egE4/+wIqgxWuUIBmgrWxiYP05g=";
      };
      nativeCheckInputs = [pkgs.vimPlugins.nvim-paredit];
    })
  ];
}
