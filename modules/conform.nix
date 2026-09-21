{
  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        lsp_format = "first";

        formatters_by_ft = {
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          javascript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          nix = [ "nixfmt" ];
          java = [ "google-java-format" ];
          kotlin = [ "ktlint" ];
          yaml = [ "yamlfix" ];
          bash = [ "beautysh" ];
          just = [ "jsut" ];
          markdown = [ "markdownlint-cli2" ];
          rust = [ "rustfmt" ];
          html = [ "htmlbeautifier" ];
          "*" = [
            "codespell"
            "trim_whitespace"
          ];
          "_" = [ "trim_whitespace" ];
        };
      };
    };
  };
}
