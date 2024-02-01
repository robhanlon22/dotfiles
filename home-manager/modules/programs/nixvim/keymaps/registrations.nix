{
  config,
  lib,
  ...
}:
with lib; {
  options.my.nixvim.which-key.register = mkOption (with types; {
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
    programs.nixvim.extraConfigLua = let
      isntEmpty = v: v != {};
    in
      strings.concatMapStringsSep "\n" (
        {
          mappings,
          opts,
        }: let
          args = pipe [mappings opts] [
            (map (v: strings.optionalString (isntEmpty v) (lib.nixvim.toLuaObject v)))
            (lists.remove "")
            (strings.concatStringsSep ", ")
          ];
        in
          lib.strings.optionalString (isntEmpty mappings) ''
            require("which-key").register(${args})
          ''
      )
      config.my.nixvim.which-key.register;
  };
}
