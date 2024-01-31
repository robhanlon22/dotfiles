{lib, ...}:
with lib.my.nixvim.keymap; {
  imports = [
    ./registrations.nix
    ./barbar.nix
    ./telescope.nix
    ./lsp.nix
    ./ufo.nix
  ];

  my.nixvim.which-key.register = [
    {
      mappings = {
        "<F9>" = wk.vim "FloatermToggle" "Toggle floating terminal";
      };
      opts = {
        mode = ["n" "t"];
      };
    }
    {
      mappings = {
        "<F10>" = "${ctrl- "\\"}${ctrl- "n"}";
      };
      opts = {
        mode = ["t"];
      };
    }
  ];
}
