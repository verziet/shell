{
  description = "Acheron quickshell configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts/main";

    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {
        self',
        system,
        pkgs,
        ...
      }: {
        packages = {
          quickshell = pkgs.writeShellScriptBin "quickshell" ''${inputs.quickshell.packages.${system}.default}/bin/quickshell -p .'';
          default = self'.packages.quickshell;
        };

        apps.default = {
          type = "app";
          program = "${self'.packages.quickshell}/bin/quickshell";
        };

        formatter = pkgs.alejandra;
      };
    };
}
