#[cxx::bridge(namespace = "foo")]
pub mod ffi {
    // C++ types and signatures exposed to Rust.
    unsafe extern "C++" {
        include!("libf-u/src/include/flake.hh");

        fn create_stuff();
    }
}
