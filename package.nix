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

  cargoHash = "sha256-ZLO/ledIKGku5X9nskFj1YCsjYcbrmmUIB5noMggoVw=";

  nativeBuildInputs = [
    clang
    pkg-config
    rustPlatform.bindgenHook
    cargo
    rustc
  ];

  buildInputs = [
    boost
    (nix.overrideAttrs (old: { CXXFLAGS = (old.CXXFLAGS or "") + " -Og" + " -frecord-gcc-switches"; patches = old.patches ++ [ ./disable_sigsegv_handle.patch ]; }))
  ];

  RUST_BACKTRACE = "full"; # remove when bindgen works
}
