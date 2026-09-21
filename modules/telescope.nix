{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>fG" = "live_grep";
      "<leader>ff" = "find_files";
      "<leader>fO" = "oldfiles";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader><Tab>";
      action.__raw = "function() require'telescope.builtin'.buffers({sort_mru=true, sort_lastused=true}) end";
      options.desc = "Find buffers (sorted)";
    }
    {
      mode = "n";
      key = "<leader><leader><Tab>";
      action.__raw = "require'telescope.builtin'.resume";
      options.desc = "Resume telescope";
    }
    {
      mode = "n";
      key = "<leader>fo";
      action = "<Cmd>lua require'telescope.builtin'.oldfiles({cwd_only=true,cwd=vim.fn.systemlist(\"git -C \" .. vim.fn.expand(\"%:p:h\") .. \" rev-parse --show-toplevel\")[1]})<CR>";
      options.desc = "Find recent file in repo";
    }

    {
      mode = "n";
      key = "<leader>fg";
      action = "<Cmd>lua require'telescope.builtin'.live_grep({cwd=vim.fn.systemlist(\"git -C \" .. vim.fn.expand(\"%:p:h\") .. \" rev-parse --show-toplevel\")[1]})<CR>";
      options.desc = "Grep in repo";
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>fs";
      action = "<Cmd>Telescope grep_string<CR>";
      options.desc = "String grep";
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>fs";
      action = "<Cmd>Telescope lsp_incoming_calls<CR>";
      options.desc = "Incoming calls";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<Cmd>Telescope git_branches<CR>";
      options.desc = "Git branches";
    }

    {
      mode = "n";
      key = "<leader>fc";
      action = "<Cmd>Telescope git_commits<CR>";
      options.desc = "Git commits";
    }
  ];
}
