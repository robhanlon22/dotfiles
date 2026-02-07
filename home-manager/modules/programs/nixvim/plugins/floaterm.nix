{nixvimKeymap, ...}: {
  programs.nixvim.plugins.floaterm.enable = true;

  my.programs.nixvim.plugins.which-key.register = with nixvimKeymap; [
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
        "<F9>" = wk.generic "${ctrl- "\\"}${ctrl- "n"}" "Enter normal mode in terminal";
      };
      opts = {
        mode = ["t"];
      };
    }
  ];
}
