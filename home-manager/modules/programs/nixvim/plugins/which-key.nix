{
  my,
  lib,
  ...
}:
with lib; {
  options.my.programs.nixvim.plugins.which-key.register = mkOption (with types; {
    type = listOf (submodule {
      options = {
        mappings = mkOption {
          type = attrsOf anything;
          default = {};
          description = "Manually register the description of mappings.";
          example = {
            "<leader>p" = "Find git files with telescope";
          };
        };
        opts = mkOption {
          type = attrsOf anything;
          default = {};
          description = "Options to which-key.register";
          example = {
            mode = "n";
            # prefix: use "<leader>f" for example for mapping everything related to finding files
            # the prefix is prepended to every mapping part of `mappings`
            prefix = "";
            buffer = null; # Global mappings. Specify a buffer number for buffer local mappings
            silent = true; # `silent` when creating keymaps
            noremap = true; # `noremap` when creating keymaps
            nowait = false; # `nowait` when creating keymaps
            expr = false; # `expr` when creating keymaps
          };
        };
      };
    });
  });

  config = {
    programs.nixvim = {
      plugins.which-key.enable = true;

      extraConfigLua =
        strings.concatMapStringsSep "\n" (
          {
            mappings,
            opts,
          }: let
            args = pipe [mappings opts] [
              (lists.remove {})
              (map my.nixvim.toLuaObject)
              (strings.concatStringsSep ", ")
            ];
          in
            lib.strings.optionalString (mappings != {}) ''
              require("which-key").register(${args})
            ''
        )
        my.programs.nixvim.plugins.which-key.register;
    };
  };
}
