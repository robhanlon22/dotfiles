{pkgs, ...}: let
  grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    tree-sitter-bash
    tree-sitter-clojure
    tree-sitter-fennel
    tree-sitter-graphql
    tree-sitter-java
    tree-sitter-json
    tree-sitter-lua
    tree-sitter-markdown
    tree-sitter-markdown-inline
    tree-sitter-nix
    tree-sitter-regex
    tree-sitter-ruby
    tree-sitter-scss
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
    incrementalSelection = {enable = true;};
  };
}
