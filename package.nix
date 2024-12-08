{
  buildRustCrate,
  boost,
  nix,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "f-u++";
  version = "1.0.0";
  src = ./.;
  buildInputs = [
    nix
    boost
  ];
  # buildInputs doesn't expose this path automatically (needed to pull in
  # "args.hh")
  CXXFLAGS = [
    "-I${nix.dev}/include/nix "
    "-DHAVE_BOEHMGC=1"
    "-DSYSTEM='\"${stdenv.hostPlatform.system}\"'"
    "-Og"
  ];
  # put the binary in /bin so that we can `nix run` it.
  dontFixup = 1;
  dontStrip = 1;

  installPhase = ''
    mkdir -p $out/bin;
    mv ./f-u++ $out/bin/f-u++;
  '';
}
