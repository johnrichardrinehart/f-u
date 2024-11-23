use std::env;
use std::path::PathBuf;

fn main() {
    // Tell cargo to look for shared libraries in the specified directory
    // println!("cargo:rustc-link-search=/path/to/lib");

    // Tell cargo to tell rustc to link the system bzip2
    // shared library.
    // println!("cargo:rustc-link-lib=bz2");

    let flakelib = pkg_config::Config::new()
        .atleast_version("2.24.0")
        .probe("nix-flake")
        .unwrap();

    // print!("{}", flakelib.include_paths.iter().map(|x| x.to_string_lossy()).collect::<Vec<std::borrow::Cow<str>>>().join(" "));

    // The bindgen::Builder is the main entry point
    // to bindgen, and lets you build up options for
    // the resulting bindings.
    let mut builder = bindgen::Builder::default()
        // The input header we would like to generate
        // bindings for.
        .header("./src/lib/binding.h");

    for header in flakelib.include_paths.iter() {
        builder = builder.clang_arg(format!("-I{}", header.to_string_lossy()));
    }

    // .clang_args(flakelib.include_paths.iter().map(|x| format!("-I{} ", x.to_string_lossy())))
    // Tell cargo to invalidate the built crate whenever any of the
    // included header files changed.
    let bindings = builder
        .parse_callbacks(Box::new(bindgen::CargoCallbacks))
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
