{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs; (
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
  );
}
