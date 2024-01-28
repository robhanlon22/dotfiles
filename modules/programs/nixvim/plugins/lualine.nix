_:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    theme = "dracula-nvim";
    globalstatus = true;
    componentSeparators = {
      left = "|";
      right = "|";
    };
    sectionSeparators = {
      left = "";
      right = "";
    };
  };
}
