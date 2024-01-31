{lib, ...}: {
  keymap = let
    mkMod = m: k: "<${m}-${toString k}>";
  in rec {
    leader = "<leader>";
    leader- = k: "${leader}${toString k}";
    alt- = mkMod "A";
    ctrl- = mkMod "C";
    wk = {
      group = name: attrs: {inherit name;} // attrs;
      vim = command: desc: ["<cmd>${toString command}<cr>" desc];
      lua = fn: desc: [(lib.nixvim.mkRaw fn) desc];
    };
  };
}
