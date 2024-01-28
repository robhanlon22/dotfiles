{ pkgs, ... }:

let
  grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    tree-sitter-clojure
    tree-sitter-fennel
    tree-sitter-graphql
    tree-sitter-java
    tree-sitter-json
    tree-sitter-lua
    tree-sitter-nix
    tree-sitter-ruby
    tree-sitter-scss
    tree-sitter-typescript
    tree-sitter-yaml
  ];
in {
  programs.nixvim.plugins.treesitter = {
    enable = true;
    inherit grammarPackages;
    ensureInstalled = map ({ language }: language) grammarPackages;
  };
}
