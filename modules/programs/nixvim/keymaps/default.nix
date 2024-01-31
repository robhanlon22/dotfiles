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
        "<F10>" = wk.vim "FloatermToggle" "Toggle floating terminal";
      };
      opts = {
        mode = ["n" "t"];
      };
    }
    {
      mappings = {
        "<F9>" = ["${ctrl- "\\"}${ctrl- "n"}" "Enter normal mode in terminal"];
      };
      opts = {
        mode = ["t"];
      };
    }
  ];
}
