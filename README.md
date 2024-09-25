

# Rust O11y

A starter for setting up Observability with Rust using prometheus, and grafana

![Logo](o11y-crab.png)

## Pre-requisites

you'll need to install:

- [rust](https://www.rust-lang.org/tools/install)
- [docker](https://docs.docker.com/get-docker/)

there are also some os-specific requirements.

### windows
  
```bash
cargo install -f cargo-binutils
rustup component add llvm-tools-preview
```

### linux

```bash
# ubuntu 
sudo apt-get install lld clang
# arch 
sudo pacman -S lld clang
```

### macos

```bash
brew install michaeleisel/zld/zld
```

## how to build

launch `cargo`:

```bash
cargo build
```

## how to test

launch `cargo`:

```bash
cargo test 
```

## running the app with docker

to run the application, prometheus, and grafana for observability, use `docker-compose`:

```bash
docker-compose up --build
```

this will:

- start the app on `localhost:8000`
- prometheus on `localhost:9090`
- grafana on `localhost:3000` (username: 'admin' password: `secret`)


## observability metrics

the app uses [actix-web-prom](https://crates.io/crates/actix-web-prom) to expose prometheus metrics at `/metrics`.

### health check

the app provides a health check endpoint at `/health_check`.


### using the Makefile

to build, test, and run the project or use git commands,  execute `make <target>` in your terminal. for example, `make build` to build the project or `make git-status` to check git status.


