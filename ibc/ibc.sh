#!/bin/bash

IBC0="h3liax"
IBC1="cosmoshub-4"

# copy hermes config
mkdir -p $HOME/.hermes
cp ibc/config.toml ~/.hermes/config.toml

# build 
cd ibc-rs

echo "Building the Rust relayer..."
cargo build -q --locked

# add the key seeds to the keyring of each chain
echo "Importing keys..."
cargo run --bin hermes -- -c ~/.hermes/config.toml keys add $IBC1 -f "/home/ec2-user/node-stargate/key_seed.json" 
cargo run --bin hermes -- -c ~/.hermes/config.toml keys add $IBC0 -f "/home/ec2-user/node-heliax/key_seed.json"

echo "Done!"
