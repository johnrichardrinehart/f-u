#[cxx::bridge(namespace = "foo")]
pub mod ffi {
    // C++ types and signatures exposed to Rust.
    unsafe extern "C++" {
        include!("f-u/src/lib/include/binding.hh");

        type Flake;

        fn read_flake() -> UniquePtr<Flake>;

        fn hello();
    }
}
