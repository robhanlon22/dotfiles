{config, ...}:
with config.my.lib.nixvim.keymap; {
  programs.nixvim.plugins.which-key.registrations = {
    ${leader- "c"} = wk.group "LSP" {};
  };
}
