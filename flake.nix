{
  description = "F-U!!!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = (
          import nixpkgs {
            inherit system;
          }
        );
        pkgsLibcxxStdenv =
          let
          patchedPkgs = pkgs.applyPatches {
            src = nixpkgs;
            name = "144747.patch";
            patches = [ ./144747.patch ];
          };
        in
          (import patchedPkgs) {
            inherit system;
            config.replaceStdenv = (
              { pkgs, ... }:
              let
                # Bootstrap a new stdenv that includes a modified glibc
                glibc = pkgs.glibc.overrideDerivation (old: {
                  postInstall =
                    old.postInstall
                    + ''
                      touch $out/MODIFIED_GLIBC
                    '';
                });
                binutils = pkgs.binutils.override {
                  libc = glibc;
                };
                gcc = pkgs.gcc.override {
                  bintools = binutils;
                  libc = glibc;
                };
              in
              builtins.trace "Enabling Custom Stdenv" pkgs.libcxxStdenv.override {
                cc = gcc;
                overrides = self: super: {
                  inherit glibc binutils gcc;
                };
                allowedRequisites = pkgs.stdenv.allowedRequisites ++ [
                  glibc.out
                  glibc.dev
                  glibc.bin
                  binutils
                ];
              }
            );
          };
      in
      {
        packages = rec {
          default = pkgs.callPackage ./package.nix { };
          dbg = pkgs.enableDebugging default;
          defaultLibcxxStdenv = pkgsLibcxxStdenv.callPackage ./package.nix { };
          defaultClangStdenv = pkgs.callPackage ./package.nix {
            stdenv = pkgs.clangStdenv;
          };
        };
      }
    );
}
