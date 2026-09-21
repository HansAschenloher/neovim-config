{
  programs.nixvim = {
    plugins.undotree.enable = true;
    keymaps = [
      {
        action = "<cmd>w !sudo tee > /dev/null %<CR>";
        key = "w!!";
        mode = "c";
        options = {
          silent = true;
          unique = true;
        };
      }
    ];
  };
}
