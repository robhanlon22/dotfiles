{my, ...}: {
  programs.nixvim.plugins.bufferline.enable = true;

  my.programs.nixvim.plugins.which-key.register = with my.nixvim.keymap; [
    {
      opts.prefix = leader;
      mappings = {
        b = {
          type = "group";
          group = "Buffer";
          expand = "conf.which_key.buffers";
          mappings = {
            p = wk.vim "BufferLineCyclePrev" "Previous";
            n = wk.vim "BufferLineCycleNext" "Next";
            f = wk.vim "BufferLinePick" "Pick";
            P =
              wk.vim "BufferLineMovePrev" "Move to previous position";
            N = wk.vim "BufferLineMoveNext" "Move to next position";
            d = wk.vim "bdelete" "Close";
            K = wk.vim "BufferLineCloseOthers" "Close others";
            s = wk.vim "BufferLineTogglePin" "Pin";
            o = wk.group "Sort" {
              d = wk.vim "BufferLineSortByDirectory" "Sort by directory";
              l = wk.vim "BufferLineSortByExtension" "Sort by extension";
              w = wk.vim "BufferLineSortByTabs" "Sort by tabs";
            };
          };
        };
      };
    }
  ];
}
