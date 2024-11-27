{
  description = "F-U!!!";

  inputs = {
    nix.url = "github:nixos/nix?ref=2.24-maintenance";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nix,
      nixpkgs,
      flake-utils,
      treefmt,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [
            (self: super: {
              nixVersions.nix_2_24_clangStdenv = nix.packages.${system}.nix-clangStdenv;
            })
          ];
        });
      in
      rec {
        packages = {
          default = pkgs.callPackage ./package.nix {
            nix = pkgs.nixVersions.nix_2_24_clangStdenv;
          };
        };
        devShells = {
          default = packages.default.overrideAttrs (old: {
            nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.rust-analyzer ];
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
