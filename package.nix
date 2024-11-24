{
  rustPlatform,
  nix,
  pkg-config,
  stdenv,
  libclang,
  libcxx,
  llvmPackages,
  clang,
  lib,
  clangStdenv,
  cargo,
  rustc,
  boost,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "f-u";
  version = "1.0.0";

  src = ./.;

  cargoHash = "sha256-dziLvZb1QVhDly+OjkSMU6+XB5+7GFOZZ8GFENk9UL8=";

  nativeBuildInputs = [
    clang
    pkg-config
    rustPlatform.bindgenHook
    cargo
    rustc
  ];

  buildInputs = [
    boost
    nix
  ];

  RUST_BACKTRACE="full"; # remove when bindgen works
}
