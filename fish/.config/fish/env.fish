# General paths
set -e EDITOR
set -g -x EDITOR nvim

# Rust
set -gx PATH $HOME/.cargo/bin $PATH
set -gx RUST_SRC_PATH /Users/holmgr/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
