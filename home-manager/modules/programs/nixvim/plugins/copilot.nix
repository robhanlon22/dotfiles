{
  programs.nixvim = {
    plugins.copilot-vim.enable = true;
    globals.copilot_no_tab_map = true;
  };
}
