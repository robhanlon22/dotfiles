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
          name = "smart-open-nvim";
          src = fetchFromGitHub {
            owner = "danielfalk";
            repo = "smart-open.nvim";
            rev = "main";
            hash = "sha256-N0lDSYiHY6+IQ2AJ3dxZlNqgan49y/yw050LvvMrZdM=";
          };
        }
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
