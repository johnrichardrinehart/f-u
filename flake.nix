{
  description = "F-U!!!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = (import nixpkgs { inherit system; } );
  in rec {
    packages = {
      default = pkgs.callPackage ./package.nix {};
    };
    devShells = {
      default = pkgs.mkShell {
        inputsFrom = [ packages.default ];
        nativeBuildInputs = [ pkgs.rust-analyzer ];
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
      };
    };
  });
}
