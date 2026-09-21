{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "dap"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lua"; }
          { name = "treesitter"; }
          { name = "vsnip"; }
          { name = "yank"; }
          {
            name = "buffer";
            keyword_length = 4;
          }
          {
            name = "path";
            keyword_length = 4;
          }
          {
            name = "spell";
            keyword_length = 4;
          }
          {
            name = "tags";
            keyword_length = 4;
          }
        ];
      };
    };

    keymaps = [
      {
        mode = "i";
        key = "<C-Space>";
        action.__raw = "require 'cmp'.mapping.confirm({select = true})";
      }
      {
        mode = "i";
        key = "<C-n>";
        action.__raw = "require 'cmp'.mapping.select_next_item()";
      }
      {
        mode = "i";
        key = "<C-p>";
        action.__raw = "require 'cmp'.mapping.select_prev_item()";
      }
    ];
  };
}
