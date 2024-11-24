extern crate cxxbridge;

fn main() {
    fu::ffi::hello();
    let flake = fu::ffi::read_flake();
    drop(flake);
}
