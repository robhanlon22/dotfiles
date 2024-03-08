{
  config,
  my,
  ...
}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file_browser.enable = true;
      fzf-native = {
        enable = true;
        overrideGenericSorter = true;
        overrideFileSorter = true;
      };
      ui-select.enable = true;
      undo.enable = true;
    };
    extraOptions = {
      pickers.find_files = {
        find_command = ["fd" "--type" "f" "--color" "never"];
        hidden = true;
      };
      extensions.ui-select = [
        (config.nixvim.helpers.mkRaw "conf.telescope.extensions.ui_select.dropdown")
      ];
    };
  };

  my.programs.nixvim.plugins.which-key.register = with my.lib.nixvim.keymap; let
    telescope = s: wk.vim "Telescope ${s}";
  in [
    {
      opts.prefix = leader;
      mappings = {
        ${leader} = telescope "find_files" "Find files";
        s = wk.group "Telescope" {
          b = telescope "buffers" "Buffers";
          d = telescope "zoxide list" "Zoxide";
          f = telescope "file_browser" "File browser";
          o = telescope "smart_open" "Smart open";
          p = telescope "live_grep" "Live grep";
          s = telescope "builtin" "Builtin";
          u = telescope "undo" "Undo";
        };
      };
    }
  ];
}
