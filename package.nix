{ buildRustCrate, ... }: buildRustCrate {
  src = ./.;
  crateName = "f-u";
  version = "1.0.0";
}
