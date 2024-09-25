use std::net::TcpListener;
use RustO11y::run;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    let address = TcpListener::bind("0.0.0.0:8000")?;
    run(address)?.await
}
