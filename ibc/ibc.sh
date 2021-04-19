#!/bin/bash

# copy hermes config
mkdir -p $HOME/.hermes
cp ibc/config.toml ~/.hermes/config.toml

# build 
cd ibc-rs

echo "Building the Rust relayer..."
cargo build &> /dev/null

# add the key seeds to the keyring of each chain
echo "Importing keys..."
cargo run --bin hermes -- -c ~/.hermes/config.toml keys add "stargate" "/home/ec2-user/node-stargate/key_seed.json" 
cargo run --bin hermes -- -c ~/.hermes/config.toml keys add "heliax" "/home/ec2-user/node-heliax/key_seed.json"

echo "Done!"
