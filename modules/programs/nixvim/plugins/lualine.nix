{lib, ...}: {
  programs.nixvim.plugins.lualine = lib.my.config.enabled {
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
