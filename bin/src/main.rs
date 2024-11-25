fn pluralize_dogs(cnt: u32) -> String {
    return format!(
        "I'm pluralizing: {}",
        libf_u::ffi::pluralize(cnt, "dog", "dogs")
    );
}

fn main() {
    for num in 0..3 {
        println!("{}", pluralize_dogs(num));
    }
    libf_u::ffi::read_flake();
}
