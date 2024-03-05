{pkgs, ...}: {
  programs.nixvim.extraPlugins = map pkgs.vimUtils.buildVimPlugin [
    {
      name = "nvim-paredit";
      src = pkgs.fetchFromGitHub {
        owner = "julienvincent";
        repo = "nvim-paredit";
        rev = "master";
        hash = "sha256-sMW4V9T7C2A5DgYHlD1SU8Aq8a5qaBIuDXTIkTHR9dM=";
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
