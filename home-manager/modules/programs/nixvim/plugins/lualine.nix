{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings.options = {
      globalstatus = true;
      section_separators = {
        left = "";
        right = "";
      };
      component_separators = {
        left = "";
        right = "";
      };
    };
  };
}
