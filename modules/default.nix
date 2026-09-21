{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./cmp.nix
    ./conform.nix
    ./dap.nix
    ./lsp.nix
    ./neoclip.nix
    ./ntree.nix
    ./telescope.nix
    ./treesitter.nix
    ./undotree.nix
    ./utils.nix
  ];
  colorschemes.gruvbox-material-nvim.enable = false;
  opts = {
    background = "dark";
    colorcolumn = "80";
    completeopt = "menu,menuone,noselect";
    copyindent = true;
    cursorlineopt = "number";
    cursorline = true;
    expandtab = true;
    foldlevelstart = 99;
    foldmethod = "indent";
    hidden = true;
    hlsearch = true;
    ignorecase = true;
    incsearch = true;
    linebreak = true;
    listchars = "tab:▸ ,trail:␣,nbsp:~,extends:…";
    list = true;
    magic = true;
    mouse = "nv";
    number = true;
    preserveindent = true;
    relativenumber = true;
    scrolloff = 2;
    shiftwidth = 2;
    showmatch = true;
    sidescrolloff = 3;
    signcolumn = "yes";
    smartcase = true;
    smarttab = true;
    softtabstop = 2;
    splitbelow = true;
    splitright = true;
    tabstop = 2;
    termguicolors = true;
    undofile = true;
    updatetime = lib.mkForce 300;
    visualbell = true;
    winwidth = 80;
  };

  globals = {
    mapleader = " ";
    makeprg = "./lint";
  };

  performance = {
    byteCompileLua = {
      enable = true;
      initLua = true;
      luaLib = true;
      nvimRuntime = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>qn";
      action = "<cmd>cnext<CR>";
      options.desc = "Quickfix Next";
    }
    {
      mode = "n";
      key = "<leader>qp";
      action = "<cmd>cprevious<CR>";
      options.desc = "Quickfix Previous";
    }
  ];

  plugins = {
    gitgutter.enable = true;
    lualine.enable = true;
    markdown-preview.enable = true;
    refactoring.enableTelescope = true;
    refactoring.enable = true;
    tmux-navigator.enable = true;
    todo-comments.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
    git-conflict.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    git-blame-nvim
    nerdcommenter
    nvim-dap-ui
    nvim-dap-vscode-js
    vim-devicons
    vim-nix
  ];

  extraConfigLua = /* lua */ ''
    local function delete_qf_entry()
      local qf = vim.fn.getqflist()
      local idx = vim.fn.line('.') - 1

      if qf[idx + 1] then
        table.remove(qf, idx + 1)
        vim.fn.setqflist(qf, 'r')
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "qf",
      callback = function()
        vim.keymap.set("n", "dd", delete_qf_entry, {
          buffer = true,
          desc = "Delete quickfix entry",
        })
      end,
    })
  '';
}
