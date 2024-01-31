{lib, ...}:
with lib.my.nixvim.keymap; {
  my.nixvim.which-key.register = [
    {
      mappings = {
        b = wk.group "Buffer" (
          let
            bufferGoto = lib.my.attrsets.fromList (n: let
              s = toString n;
            in {
              name = s;
              value = wk.vim "BufferGoto ${s}" "Go to buffer ${s}";
            }) (lib.lists.range 1 9);
          in
            {
              p = wk.vim "BufferPrevious" "Previous";
              n = wk.vim "BufferNext" "Next";
              P =
                wk.vim "BufferMovePrevious" "Move to previous position";
              N = wk.vim "BufferMoveNext" "Move to next position";
              d = wk.vim "BufferClose" "Close";
              D = wk.vim "BufferRestore" "Restore";
              K = wk.vim "BufferCloseAllButCurrentOrPinned" "Close all but current or pinned";
              s = wk.vim "BufferPin" "Pin";
              o = {
                b = wk.vim "BufferOrderByBufferNumber" "Order by buffer number";
                d = wk.vim "BufferOrderByDirectory" "Order by directory";
                l = wk.vim "BufferOrderByLanguage" "Order by language";
                w = wk.vim "BufferOrderByWindowNumber" "Order by window number";
              };
            }
            // bufferGoto
        );
      };
      opts.prefix = leader;
    }
  ];
}
