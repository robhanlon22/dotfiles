{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs;
    (
      with vimPlugins; [
        dracula-nvim
        dressing-nvim
        fuzzy-nvim
        hotpot-nvim
        nvim-lspconfig
        plenary-nvim
        sqlite-lua
        telescope-zoxide
      ]
    )
    ++ (
      map vimUtils.buildVimPlugin [
        {
          name = "virt-column-nvim";
          src = fetchFromGitHub {
            owner = "lukas-reineke";
            repo = "virt-column.nvim";
            rev = "master";
            hash = "sha256-7ljjJ7UwN2U1xPCtsYbrKdnz6SGQGbM/HrxPTxNKlwo=";
          };
        }
      ]
    );
}
