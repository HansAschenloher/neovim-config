{
  imports = [
    ./treesitter/grammar-xquery.nix
  ];
  programs.nixvim.plugins = {
    treesitter = {
      enable = false;
      #highlight.enable = true;
      #folding.enable = true;
      #indent.enable = true;
      settings = {
        incremental_selection.enable = true;
        nixvimInjections = true;
        auto_install = true;
        ensure_installed = [
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
        ];
      };
      luaConfig.post = /* lua */ ''
        -- Override / extend TypeScript injections
        local ts_query = require("vim.treesitter.query")

        local injection_query = [[
          (
            (comment) @injection.language
            .
            (template_string) @injection.content
            (#match? @injection.language "/.*\s*([\w_+-]+)\s*.*/")
          )
        ]]

        ts_query.set("typescript", "injections", injection_query)
        ts_query.set("tsx", "injections", injection_query)
      '';

    };

    treesitter-textobjects.enable = false;
    treesitter-refactor = {
      enable = false;
      settings.highlightDefinitions.enable = true;
      settings.highlightCurrentScope.enable = false;
      settings.smartRename.enable = true;
      settings.smartRename.keymaps.smartRename = "grr";
      settings.navigation.keymaps = {
        gotoDefinition = "<leader>gd";
        listDefinitions = "<leader>ld";
        listDefinitionsToc = "<leader>lD";
        gotoNextUsage = "<leader>gn";
        gotoPreviousUsage = "<leader>gp";
      };
    };
  };
}
