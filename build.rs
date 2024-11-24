use std::env;
use std::path::PathBuf;

fn main() {
    let flakelib = pkg_config::Config::new()
        .atleast_version("2.24.0")
        .probe("nix-flake")
        .unwrap();

    cxx_build::bridge("src/lib/lib.rs")
        .file("src/lib/binding.cc")
        .std("c++20")
        .includes(flakelib.include_paths.iter())
        .compile("cxxbridge");

    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rerun-if-changed=src/main.rs");
    println!("cargo:rerun-if-changed=src/flake.cc");
}
