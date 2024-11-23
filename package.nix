{
  buildRustPackage,
  nix,
  pkg-config,
  stdenv,
  libclang,
  libcxx,
  llvmPackages,
  clang,
  lib,
  clangStdenv,
  ...
}:
buildRustPackage {
  pname = "f-u";
  version = "1.0.0";

  src = ./.;

  cargoHash = "sha256-1XQovks7DHjOs/6Grh+lmn8m39GHrQIwqu/G10mSmFw=";

  LIBCLANG_PATH = "${libclang.lib}/lib";

  nativeBuildInputs = [
    clang
    pkg-config
  ];
  buildInputs = [
    nix
    libclang.lib
  ];

  # below taken from https://hoverbear.org/blog/rust-bindgen-in-nix/
  shellHook = builtins.trace "stdenv cc is ${stdenv.cc.cc.name}-${stdenv.cc.cc.version}" ''
    # From: https://github.com/NixOS/nixpkgs/blob/1fab95f5190d087e66a3502481e34e15d62090aa/pkgs/applications/networking/browsers/firefox/common.nix#L247-L253
    # Set C flags for Rust's bindgen program. Unlike ordinary C
    # compilation, bindgen does not invoke $CC directly. Instead it
    # uses LLVM's libclang. To make sure all necessary flags are
    # included we need to look in a few places.
    export BINDGEN_EXTRA_CLANG_ARGS="$(< ${stdenv.cc}/nix-support/libc-crt1-cflags) \
      $(< ${stdenv.cc}/nix-support/libc-cflags) \
      $(< ${stdenv.cc}/nix-support/cc-cflags) \
      #$(< ${stdenv.cc}/nix-support/libcxx-cxxflags) \
      ${lib.optionalString stdenv.cc.isClang "-idirafter ${stdenv.cc.cc}/lib/clang/${lib.getVersion stdenv.cc.cc}/include"} \
      ${lib.optionalString stdenv.cc.isGNU "-isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc} -isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc}/${stdenv.hostPlatform.config}"}
    "
  '';
}
