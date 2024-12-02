use std::env::Args;

fn main() {
    let args = std::env::args();
    let url = args.skip(1).next().expect("flake URL should be the 1st argument.");


    let flake = libf_u::ffi::get_flake(url.to_string(), true);

    let inputs = flake.list_inputs();

    println!("Found {} flake inputs.", inputs.len());
    for input in inputs.iter() {
        println!("input: {}", &input.to_string());
    }
}
