use std::env;
use std::fs::write;
use std::process::exit;

fn main() {
    println!("Hello, world!");
    let github_output_path = env::var("GITHUB_OUTPUT").unwrap();

    let args: Vec<String> = env::args().collect();
    let error = &args[0];

    if !error.is_empty() {
        eprintln!("Error: {error}");
        write(github_output_path, format!("error={error}")).unwrap();
        exit(1);
    }
}
