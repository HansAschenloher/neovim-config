{ pkgs, lib, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          cssls.enable = true;
          dockerls.enable = true;
          eslint = {
            enable = true;
            filetypes = [
              "javascript"
              "javascriptreact"
              "javascript.jsx"
              "typescript"
              "typescriptreact"
              "typescript.tsx"
              "vue"
              "svelt"
              "astro"
            ];
          };
          gleam.enable = false;
          gleam.package = pkgs.gleam;
          golangci_lint_ls.enable = true;
          html.enable = true;
          hls = {
            enable = true;
            installGhc = true;
          };
          lemminx.enable = true; # XML
          ltex.enable = true;
          lua_ls.enable = true;
          marksman.enable = true;
          nixd = {
            enable = true;
            filetypes = [ "nix" ];
            settings =
              let
                flake = ''(builtins.getFlake "/etc/nixos")""'';
              in
              {
                nixpkgs = {
                  expr = "import ${flake}.inputs.nixpkgs { }";
                };
                formatting = {
                  command = [ "${lib.getExe pkgs.nixfmt}" ];
                };
              };
          };
          pyright.enable = true;
          ruff.enable = true;

          ts_ls = {
            enable = true;
            settings = {
              preferences = {
                disableSuggestions = true;
                includeInlayParameterNameHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
              };
              filetypes = [
                "ts"
              ];
            };
          };
          yamlls.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          vue_ls = {
            enable = true;
          };

          zls = {
            enable = true;
            filetypes = [
              "c"
              "cpp"
              "zig"
            ];
          };
        };

        keymaps = {
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
          extra = [
            {
              key = "K";
              action = "<CMD>Lspsaga hover_doc<Enter>";
            }
          ];
        };
      };

      none-ls.enable = true;
      lsp-format.enable = true;
      lsp-lines.enable = true;
      lspkind.enable = true;
      lspsaga = {
        enable = true;
        settings = {
          implement.enable = true;
          outline = {
            autoClose = true;
            autoPreview = true;
            closeAfterJump = true;
            layout = "normal"; # normal | float
            winPosition = "right";
            keys = {
              jump = "<CR>";
              quit = "<Esc>";
              toggle_or_jump = "<CR>";
            };
          };
          symbolInWinbar = {
            enable = true;
          };
          rename = {
            autoSave = false;
            keys = {
              exec = "<CR>";
              quit = "<Esc>";
              select = "x";
            };
          };
          ui = {
            border = "rounded"; # One of none, single, double, rounded, solid, shadow
            codeAction = "󰴺";
            devicon = true;
          };
          #hover = {
          #openCmd = "!vivaldi"; # Choose your browser
          #openLink = "gx";
          #};
          diagnostic = {
            borderFollow = true;
            diagnosticOnlyCurrent = false;
            showCodeAction = true;
            extendRelatedInformation = true;
          };
          codeAction = {
            extendGitSigns = false;
            showServerName = true;
            onlyInCursor = true;
            numShortcut = true;
            keys = {
              exec = "<CR>";
              quit = [
                "<Esc>"
                "q"
              ];
            };
          };
          lightbulb = {
            enable = false;
            sign = false;
            virtualText = true;
          };
          finder = {
            keys = {
              shuttle = "<Tab>";
              toggle_or_open = "<CR>";
              tabnew = "<CR>";
              quit = "<Esc>";
            };
          };
          scrollPreview = {
            scrollDown = "<C-f>";
            scrollUp = "<C-b>";
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>lc";
        action = "<Cmd>Lspsaga code_action<CR>";
        options.desc = "Code Actions";
      }
      {
        mode = "n";
        key = "<leader>li";
        action = "<Cmd>Lspsaga incoming_calls<CR>";
        options.desc = "Incoming Calls";
      }
      {
        mode = "n";
        key = "<leader>lk";
        action = "<Cmd>Lspsaga diagnostic_jump_next<CR>";
        options.desc = "Diagnistics jump next";
      }
      {
        mode = "n";
        key = "<leader>lj";
        action = "<Cmd>Lspsaga diagnostic_jump_prev<CR>";
        options.desc = "Diagnistics jump next";
      }
      {
        mode = "n";
        key = "<leader>lo";
        action = "<Cmd>Lspsaga outline<CR>";
        options.desc = "Outline";
      }
    ];
  };
}
