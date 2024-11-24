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

  cargoHash = "sha256-BVDPf7CJnrDRmZMvN3ruk4RZP4rUvq92aQFeMvzcTSs=";

  useFetchCargoVendor = true;

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
