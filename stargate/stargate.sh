#!/bin/bash

#variables
NAME="stargate"
PATH="~/node-${NAME}"

# create data folder
mkdir ${PATH}

# init node
gaiad init heliax-${NAME} --home=${PATH}

# move genesis
rm "${PATH}/config/genesis.json"
unzip "stargate/genesis.zip" -d "stargate"
cp "stargate/genesis.json" "${PATH}/config/genesis.json"

# copy config
rm "${PATH}/config/config.toml"
cp stargate/genesis.json "${PATH}/config/toml.json"

# generate key
gaiad --home --home=${PATH} keys add user --keyring-backend="test" --output json > ${PATH}/key_seed.json 2> /dev/null

# start node
gaiad start --home=${PATH} --log_level=info --x-crisis-skip-assert-invariants --pruning=nothing --grpc.address="0.0.0.0:9090"
