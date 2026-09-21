{
  programs.nixvim = {
    plugins = {
      neoclip.enable = true;
    };

    keymaps = [
      {
        key = "<leader>fp";
        action = "<Cmd>Telescope neoclip<CR>";
        mode = "n";
        options.desc = "Find in past register";
      }
    ];
  };
}
