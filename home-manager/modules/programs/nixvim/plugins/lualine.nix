{lib, ...}: {
  programs.nixvim.plugins.lualine = lib.my.config.enabled {
    globalstatus = true;
    sectionSeparators = {
      left = "";
      right = "";
    };
    componentSeparators = {
      left = "";
      right = "";
    };
  };
}
