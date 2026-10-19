{ pkgs, ... }:
let
  js-dap-port = 9229;
in
{
  plugins = {
    dap = {
      enable = true;
      adapters = {
        servers = {
          pwa-node = {
            host = "127.0.0.1";
            port = 4711;

            executable = {
              command = "node";
              args = [
                # Path to dapDebugServer.js
                "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js"
                (toString 4711)
                "127.0.0.1"
              ];
            };
          };
        };
      };
      configurations = {
        javasript = [
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach to Node";
            port = js-dap-port;
            #cwd = "\${workspaceFilder}";
            sourceMaps = true;
            skipFiles = [ "<node-internals>/**" ];
          }
        ];

        typescript = [
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach to Node";
            port = js-dap-port;
            #cwd = "\${workspaceFilder}";
            sourceMaps = true;
            trace = true;
            skipFiles = [ "<node-internals>/**" ];
          }
        ];
      };
    };
    dap-python.enable = true;
    dap-ui.enable = true;
    dap-view.enable = true;
    dap-virtual-text.enable = true;
  };

  keymaps = [
    {
      key = "<leader>dc";
      mode = [ "n" ];
      action.__raw = ''
        function()
          local condition = vim.fn.input("Breakpoint condition: ")
          if condition ~= "" then
            require("dap").set_breakpoint(condition)
          end
        end
      '';
      options.desc = "Set conditional breakpoint";
    }

    {
      key = "<leader>db";
      mode = [ "n" ];
      action = ":DapToggleBreakpoint<CR>";
      options.desc = "Toggle Breakpoint";
    }

    {
      key = "<leader>do";
      mode = [ "n" ];
      action = ":DapViewToggle<CR>";
      options.desc = "Toggle Debug View";
    }
  ];
}
