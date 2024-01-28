{ lib, ... }:

with lib.my.nixvim.keymap;
let
  telescope = k: leader ";${k}";
  keymap = { mode ? "n", key, lua ? null, vim ? null, desc, options ? { } }:
    let
      hasLua = lua != null;
      hasVim = vim != null;
      action = if hasLua && !hasVim then
        lua
      else if !hasLua && hasVim then
        "<cmd>${vim}<cr>"
      else
        throw "You must provide either lua or vim, not both";
    in {
      inherit mode key action;
      lua = hasLua;
      options = { inherit desc; } // options;
    };
  goToBuffer = map (n:
    let s = toString n;
    in {
      key = alt "${s}";
      vim = "BufferGoto";
      desc = "Go to buffer ${s}";
    }) (lib.lists.range 1 9);
in {
  programs.nixvim.keymaps = map keymap ([
    {
      key = leader lib.my.nixvim.leader;
      lua = "conf.telescope.frecency";
      desc = "Frecency";
    }
    {
      key = telescope "p";
      lua = "conf.telescope.zoxide";
      desc = "Zoxide";
    }
    {
      key = telescope "b";
      lua = "conf.telescope.file_browser";
      desc = "File browser";
    }
    {
      key = telescope "g";
      lua = "conf.telescope.live_grep";
      desc = "Live grep";
    }
    {
      key = telescope "t";
      vim = "Telescope";
      desc = "Telescope";
    }
    {
      key = ctrl "p";
      vim = "BufferPick";
      desc = "Pick buffer";
    }
    {
      key = alt ",";
      vim = "BufferPrevious";
      desc = "Go to previous buffer";
    }
    {
      key = alt ".";
      vim = "BufferNext";
      desc = "Go to next buffer";
    }
    {
      key = alt "<";
      vim = "BufferMovePrevious";
      desc = "Move buffer to previous position";
    }
    {
      key = alt ">";
      vim = "BufferMoveNext";
      desc = "Move buffer to next position";
    }
  ] ++ goToBuffer);
}
