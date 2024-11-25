#[cxx::bridge(namespace = "foo")]
pub mod ffi {
    // C++ types and signatures exposed to Rust.
    unsafe extern "C++" {
        include!("libf-u/src/include/flake.hh");

        type Flake;
        type FlakeInput;

        fn get_name(self: &Flake) -> String;

        fn get_flake(flakeRef: String, allowLookup: bool) -> UniquePtr<Flake>;

        // : is necessary when there's more than one `type`.
        fn list_inputs(self: &Flake) -> UniquePtr<CxxVector<FlakeInput>>;

        fn pluralize(count: u32, single: &str, plural: &str) -> String;

        fn hello();
    }
}
