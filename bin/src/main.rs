fn pluralize_dogs(cnt: u32) -> String {
    return format!(
        "I'm pluralizing: {}",
        "dog",
        //libf_u::ffi::pluralize(cnt, "dog", "dogs")
    );
}

fn main() {
    for num in 0..3 {
        println!("{}", pluralize_dogs(num));
    }

    let flake = libf_u::ffi::get_flake("github:nixos/nixpkgs".to_string(), true);
//    println!("Name is: {}", flake);
    println!("Name is: {}", flake.get_name());
}
