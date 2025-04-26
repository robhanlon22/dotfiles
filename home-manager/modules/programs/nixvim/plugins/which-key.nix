{
  my,
  lib,
  ...
}: {
  options.my.programs.nixvim.plugins.which-key.register = let
    inherit (lib) mkOption types;
  in
    mkOption {
      type = types.listOf (types.submodule {
        options = {
          mappings = mkOption {
            type = types.lazyAttrsOf (
              lib.fix (self:
                types.submoduleWith {
                  modules = [
                    {
                      options = {
                        type = mkOption {
                          type = types.enum ["group"];
                        };
                        group = mkOption {
                          type = types.str;
                        };
                        expand = mkOption {
                          type = types.nullOr types.str;
                          default = null;
                        };
                        mappings = mkOption {
                          type = types.lazyAttrsOf self;
                          default = {};
                        };
                      };
                    }
                    {
                      options = {
                        type = mkOption {
                          type = types.enum ["vim" "lua" "generic"];
                        };
                        action = mkOption {
                          type = types.str;
                        };
                        desc = mkOption {
                          type = types.nullOr types.str;
                        };
                      };
                    }
                  ];
                })
            );
            default = {};
            description = "Manually register the description of mappings.";
            example = {
              "<leader>p" = {
                type = "vim";
                action = "Telescope git_files";
                desc = "Find git files with telescope";
              };
            };
          };

          opts = mkOption {
            type = types.submodule {
              options = {
                prefix = mkOption {
                  type = types.str;
                  default = "";
                  description = "Prefix applied to all mappings.";
                };
                mode = mkOption {
                  type = types.nullOr (types.listOf types.str);
                  default = null;
                };
              };
            };
            default = {};
            description = "Options to which-key.register";
            example = {
              prefix = "<leader>f";
            };
          };
        };
      });
    };

  config = {
    programs.nixvim = {
      plugins.which-key.enable = true;

      extraConfigLua = let
        flattenedMappings =
          map (
            entry: let
              flattenMappings = prefix: mappings: (
                lib.mapAttrsToList (
                  key: val: let
                    lhs = "${prefix}${key}";

                    common = {inherit lhs;};

                    leaf = rhs:
                      common
                      // {
                        inherit (entry.opts) mode;
                        inherit (val) desc;
                        inherit rhs;
                      };

                    renderers = {
                      group = [
                        (common
                          // {
                            inherit (val) group;
                            expand =
                              if val ? expand
                              then my.nixvim.mkRaw val.expand
                              else null;
                          })
                        (flattenMappings lhs val.mappings)
                      ];

                      vim = leaf "<cmd>${val.action}<cr>";

                      lua = leaf (my.nixvim.mkRaw val.action);

                      generic = leaf val.action;
                    };
                  in
                    renderers.${val.type}
                )
                mappings
              );
            in
              flattenMappings entry.opts.prefix entry.mappings
          )
          my.programs.nixvim.plugins.which-key.register;
      in ''
        require("which-key").add(${my.nixvim.toLuaObject flattenedMappings})
      '';
    };
  };
}
