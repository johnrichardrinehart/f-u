use std::env;
use std::path::PathBuf;

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let flakelib = pkg_config::Config::new()
        .atleast_version("2.24.0")
        .probe("nix-flake")
        .unwrap();

    // The bindgen::Builder is the main entry point
    // to bindgen, and lets you build up options for
    // the resulting bindings.
    let mut builder = bindgen::Builder::default()
        // The input header we would like to generate
        // bindings for.
        .header("src/lib/binding.hh")
        .clang_arg("-std=c++20")
        ;

    for header in flakelib.include_paths.iter() {
        builder = builder.clang_arg(format!("-I{}", header.to_string_lossy()));
    }

    // Tell cargo to invalidate the built crate whenever any of the
    // included header files changed.
    let bindings = builder
        // Finish the builder and generatfe the bindings.
        .generate()
        // Unwrap the >Result and panic on failure.
        .expect("Unable to generate bindings");


    // Write the bindings to the $OUT_DIR/bindings.rs file.
    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
    bindings
        .write_to_file(out_path.join("bindings.rs"))
        .expect("Couldn't write bindings!");
}
