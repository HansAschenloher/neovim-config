{
  description = "Standalone neovim configuration";
  inputs = {
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      imports = [
        inputs.nixvim.flakeModules.default
      ];

      nixvim = {
        packages.enable = true;
        checks.enable = true;
      };

      flake.nixvimModules = {
        default = ./modules/default.nix;
      };

      perSystem =
        { system, pkgs, ... }:
        {
          # You can define actual Nixvim configurations here
          nixvimConfigurations = {
            default = inputs.nixvim.lib.evalNixvim {
              inherit system;
              modules = [
                inputs.self.nixvimModules.default
              ];
            };
          };
          packages = {
            neovim-offline = pkgs.writeShellApplication {
              name = "nvim";
              runtimeInputs = [
                pkgs.bubblewrap
                inputs.self.packages."${system}".default
                pkgs.bash
              ];
              text = ''
                bwrap --dev-bind / / --unshare-net ${
                  inputs.nixpkgs.lib.getExe inputs.self.packages."${system}".default
                } "$@"
              '';

            };
          };
        };
    };
}
