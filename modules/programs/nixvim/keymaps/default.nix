{lib, ...}:
with lib.my.nixvim.keymap; {
  imports = [./barbar.nix ./telescope.nix ./lsp.nix ./ufo.nix];

  programs.nixvim.plugins.which-key.registrations = {
    ${leader- "o"} = wk.group "Open" {
      t = wk.vim "FloatermToggle" "Toggle floating terminal";
    };
  };
}
