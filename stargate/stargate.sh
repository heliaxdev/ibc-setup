#!/bin/bash

#variables
NAME="stargate"
NODE_PATH="$HOME/node-${NAME}"

# create data folder
mkdir ${NODE_PATH}

# init node
gaiad init heliax-${NAME} --home=${NODE_PATH}

# move genesis
rm "${NODE_PATH}/config/genesis.json"
unzip "stargate/genesis.zip" -d "stargate"
cp "stargate/genesis.json" "${NODE_PATH}/config/genesis.json"

# copy config
rm "${NODE_PATH}/config/config.toml"
cp stargate/config.toml "${NODE_PATH}/config/config.toml"

# generate key
# gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --output json > ${NODE_PATH}/key_seed.json 2> /dev/null 

# import key (requires interaction)
gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --recover

# start node
screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants --pruning=nothing"
