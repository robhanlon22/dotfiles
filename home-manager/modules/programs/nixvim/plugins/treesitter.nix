{pkgs, ...}: let
  grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    tree-sitter-bash
    tree-sitter-c
    tree-sitter-clojure
    tree-sitter-comment
    tree-sitter-cpp
    tree-sitter-css
    tree-sitter-dockerfile
    tree-sitter-fennel
    tree-sitter-graphql
    tree-sitter-html
    tree-sitter-http
    tree-sitter-java
    tree-sitter-json
    tree-sitter-lua
    tree-sitter-make
    tree-sitter-markdown
    tree-sitter-markdown-inline
    tree-sitter-nix
    tree-sitter-regex
    tree-sitter-ruby
    tree-sitter-scss
    tree-sitter-sql
    tree-sitter-toml
    tree-sitter-typescript
    tree-sitter-vim
    tree-sitter-vimdoc
    tree-sitter-yaml
  ];
in {
  programs.nixvim.plugins.treesitter = {
    enable = true;
    inherit grammarPackages;
    ensureInstalled = map ({language}: language) grammarPackages;
    folding = true;
    incrementalSelection.enable = true;
  };
}
