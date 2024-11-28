{ buildRustCrate, nix, stdenv, ... }: stdenv.mkDerivation {
  name = "f-u++";
  version = "1.0.0";
  src = ./.;
  buildInputs = [ nix ];
  installPhase = ''
    touch $out;
    cp ./main $out;
    chmod +x $out;
  '';
}
