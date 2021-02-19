#!/bin/bash

# variables
NAME="heliax"
NODE_PATH="~/node-${NAME}"

# create data folder
mkdir ${NODE_PATH}

# init node
gaiad init heliax-${NAME} --home=${NODE_PATH} --chain-id=${NAME}

# add keys
gaiad keys add validator --home=${NODE_PATH}
gaiad add-genesis-account $(gaiad keys show validator -a --home=${NODE_PATH}) 1000000000stake,1000000000validatortoken --home=${NODE_PATH}
gaiad gentx validator 1000000stake --chain-id=heliax-${NAME} --home=${NODE_PATH}
gaiad collect-gentxs --home=${NODE_PATH}

# copy config
rm "${NODE_PATH}/config/config.toml"
cp stargate/genesis.json "${NODE_PATH}/config/toml.json"

# generate key
gaiad --home --home=${NODE_PATH} keys add user --keyring-backend="test" --output json > ${NODE_PATH}/key_seed.json 2> /dev/null

# start node
gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants --pruning=nothing --grpc.address="0.0.0.0:9091"