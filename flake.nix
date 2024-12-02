{
  description = "F-U!!!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = (import nixpkgs { inherit system; });
      in
      rec {
        packages = {
          default = pkgs.callPackage ./package.nix { };
        };
        devShells = {
          default = packages.default.overrideAttrs (old: {
            nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.rust-analyzer pkgs.bear ];
            CXX_FLAGS="-Og";
            RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
            CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = true;
          });
        };

        formatter =
          let
            treefmtEval = treefmt.lib.evalModule pkgs ./formatter.nix;
          in
          treefmtEval.config.build.wrapper;
      }
    );
}
