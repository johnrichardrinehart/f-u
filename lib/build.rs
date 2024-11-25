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
        .define("SYSTEM", Some(format!("\"{}\"", system()).as_str()))
        .std("c++20")
        .includes(flakelib.include_paths.iter())
        .compile("libf-u");

    // Needed to resolve _ZN3nix8fetchers8SettingsC1Ev (nix::fetcher::Settings)
    println!("cargo:rustc-link-lib=nixfetchers");
    // Needed to resolve nix::initNix()
    println!("cargo:rustc-link-lib=nixmain");

    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rerun-if-changed=src/lib.rs");
    println!("cargo:rerun-if-changed=src/flake.cc");
    println!("cargo:rerun-if-changed=src/include/flake.hh");
}

#[cfg(all(target_os = "linux", target_arch = "x86_64"))]
fn system() -> String {
    return "x86_64-linux".to_string();
}

#[cfg(all(target_os = "linux", target_arch = "aarch64"))]
fn system() -> String {
    return "aarch64-linux".to_string();
}

#[cfg(all(target_os = "macos", target_arch = "x86_64"))]
fn system() -> String {
    return "x86_64-darwin".to_string();

    #[cfg(all(target_os = "macos", target_arch = "aarch64"))]
    fn system() -> String {
        return "aarch64-darwin".to_string();
    }
}
