use std::pin::{pin, Pin};

use libf_u::ffi::EvalState;

fn main() {
    let args = std::env::args();
    let url = args.skip(1).next().expect("flake URL should be the 1st argument.");


    let flake = libf_u::ffi::get_flake(url.to_string(), true);

    let inputs = flake.list_inputs();

    println!("Found {} flake inputs.", inputs.len());
    for input in inputs.iter() {
        println!("input: {}", &input.to_string());
    }

    // let mut state: Pin<&mut libf_u::ffi::EvalState>;
    let state: EvalState = EvalState{};
    let pinned_state = pin!(state);
    let res = pinned_state.findFile("abc");

    println!("all done");
}
