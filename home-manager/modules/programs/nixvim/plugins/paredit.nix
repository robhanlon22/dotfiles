{pkgs, ...}: {
  programs.nixvim.extraPlugins = map pkgs.vimUtils.buildVimPlugin [
    {
      name = "nvim-paredit";
      src = pkgs.fetchFromGitHub {
        owner = "julienvincent";
        repo = "nvim-paredit";
        rev = "master";
        hash = "sha256-Zo40MOBSkLFSaK+x6iiNXhV9c/yNCi2jckl5VOpBDU8=";
      };
    }
    {
      name = "nvim-paredit-fennel";
      src = pkgs.fetchFromGitHub {
        owner = "julienvincent";
        repo = "nvim-paredit-fennel";
        rev = "master";
        hash = "sha256-+lQetMbP/H8cKXcxuPiQtEel5jyRDxCsfjwF+1SPVNg=";
      };
    }
  ];
}
