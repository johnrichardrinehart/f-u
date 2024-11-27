fn main() {
    println!("cargo:rustc-link-arg=-Wl,-zstack-size=4194304");
}
