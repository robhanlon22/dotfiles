{ lib, ... }:

with lib.my.nixvim.keymap; {
  programs.nixvim.plugins.which-key.registrations = let
    bufferGoto = lib.my.attrsets.fromList (n:
      let s = toString n;
      in {
        name = alt- s;
        value = wk.vim "BufferGoto ${s}" "Go to buffer ${s}";
      }) (lib.lists.range 1 9);
  in bufferGoto // {
    ${alt- "p"} = wk.vim "BufferPin" "Pin buffer";
    ${alt- "c"} = wk.vim "BufferClose" "Close buffer";
    ${alt- "s-c"} = wk.vim "BufferRestore" "Restore buffer";
    ${ctrl- "p"} = wk.vim "BufferPick" "Pick buffer";
    ${alt- ","} = wk.vim "BufferPrevious" "Go to previous buffer";
    ${alt- "."} = wk.vim "BufferNext" "Go to next buffer";
    ${alt- "<"} =
      wk.vim "BufferMovePrevious" "Move buffer to previous position";
    ${alt- ">"} = wk.vim "BufferMoveNext" "Move buffer to next position";
    ${leader} = {
      b = wk.group "Barbar" {
        b = wk.vim "BufferOrderByBufferNumber" "Order buffers by buffer number";
        d = wk.vim "BufferOrderByDirectory" "Order buffers by directory";
        l = wk.vim "BufferOrderByLanguage" "Order buffers by language";
        w = wk.vim "BufferOrderByWindowNumber" "Order buffers by window number";
      };
    };
  };
}
