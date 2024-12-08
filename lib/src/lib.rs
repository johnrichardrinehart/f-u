#[cxx::bridge(namespace = "foo")]
pub mod ffi {
    // C++ types and signatures exposed to Rust.
    unsafe extern "C++" {
        include!("libf-u/src/include/flake.hh");

        type SourcePath;
        // type Value;

        type FlakeInput;
        fn to_string(self: &FlakeInput) -> String;

        type Flake;
        // : is necessary when there's more than one type.
        fn list_inputs(self: &Flake) -> UniquePtr<CxxVector<FlakeInput>>;

        type EvalState;
        fn new_evalstate() -> Pin<&EvalState>;
        fn findFile(self: Pin<&mut EvalState>, path: &str) -> UniquePtr<SourcePath>;
        // fn evalFile(self: &EvalState, path: &SourcePath, value: &Value, mustBeTrivial: bool);

        fn get_flake(flakeRef: String, allowLookup: bool) -> UniquePtr<Flake>;
        fn pluralize(count: u32, single: &str, plural: &str) -> String;
    }
}
