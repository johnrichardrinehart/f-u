{
  description = "F-U!!!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = (import nixpkgs { inherit system; } );
  in
  {
    packages = {
      default = pkgs.callPackage ./package.nix {};
      defaultLibcxxStdenv = pkgs.callPackage ./package.nix {
        stdenv = pkgs.libcxxStdenv;
      };
      defaultClangStdenv = pkgs.callPackage ./package.nix {
        stdenv = pkgs.clangStdenv;
      };
    };
  });
}
