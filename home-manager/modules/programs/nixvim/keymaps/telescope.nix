{lib, ...}:
with lib.my.nixvim.keymap; {
  programs.nixvim.plugins.which-key.registrations = let
    telescope = s: wk.vim "Telescope ${s}";
  in {
    ${leader} = {
      ${leader} = telescope "frecency workspace=CWD" "Telescope frecency";
      s = wk.group "Telescope" {
        b = telescope "buffers" "Buffers";
        f = telescope "file_browser" "File browser";
        p = telescope "live_grep" "Live grep";
        t = telescope "builtin" "Builtin";
        u = telescope "undo" "Undo";
        d = telescope "zoxide list" "Zoxide";
      };
    };
  };
}
