{lib, ...}:
with lib.my.nixvim.keymap; {
  programs.nixvim.plugins.which-key.registrations = {
    ${leader- "c"} = wk.group "LSP code actions" {};
    ${leader- "d"} = wk.group "LSP diagnostics" {};
  };
}
