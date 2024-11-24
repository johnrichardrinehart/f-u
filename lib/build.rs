fn main() {
    let flakelib = pkg_config::Config::new()
        .atleast_version("2.24.0")
        .probe("nix-flake")
        .unwrap();

    cxx_build::bridge("src/lib.rs")
        .file("src/flake.cc")
        // kept getting
        // ```
        // warning _FORTIFY_SOURCE requires compiling with optimization (-O)
        // ```
        // So, I'm throwing this flag in here. Can probably be turned off.
        .flag_if_supported("-O3")
        .std("c++20")
        .includes(flakelib.include_paths.iter())
        .compile("libf-u");

    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rerun-if-changed=src/lib.rs");
    println!("cargo:rerun-if-changed=src/flake.cc");
    println!("cargo:rerun-if-changed=src/include/flake.hh");
}
