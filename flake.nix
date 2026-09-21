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
        #inputs.flake-parts.flakeModules.modules
        #(inputs.import-tree ./modules)
      ];

      nixvim = {
        # Automatically install corresponding packages for each nixvimConfiguration
        # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
        packages.enable = true;
        # Automatically install checks for each nixvimConfiguration
        # Run `nix flake check` to verify that your config is not broken
        checks.enable = true;
      };

      flake.nixvimModules = {
        default = ./modules/default.nix;
      };

      perSystem =
        { system, ... }:
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
        };
    };
}
