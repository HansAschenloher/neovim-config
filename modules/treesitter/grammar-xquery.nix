{ pkgs, ... }:
let
  treesitter-xquery-grammar = pkgs.tree-sitter.buildGrammar {
    language = "xquery";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "grantmacken";
      repo = "tree-sitter-xquery";
      rev = "85f15e8f6388981678838407c25f9222a7abe14b";
      hash = "sha256-1eBlgsXsZW2KnPtxIeW9HrcVSqv/YriYGT8T1OnmwaM=";
    };
    meta.homepage = "https://github.com/grantmacken/tree-sitter-xquery";
  };
in
{
  programs.nixvim.plugins.treesitter = {
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars ++ [ treesitter-xquery-grammar ];
    languageRegister.xquery = "xquery";
  };

  programs.nixvim.extraPlugins = [ treesitter-xquery-grammar ];
}
