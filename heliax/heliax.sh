#!/bin/bash

# variables
NAME="heliax"
NODE_PATH="$HOME/node-${NAME}"

# create data folder
mkdir ${NODE_PATH}

# init node
gaiad init heliax-${NAME} --home=${NODE_PATH} --chain-id=h3liax

# add keys
gaiad keys add validator --home=${NODE_PATH}
gaiad add-genesis-account $(gaiad keys show validator -a --home=${NODE_PATH}) 1000000000stake,1000000000validatortoken --home=${NODE_PATH}
gaiad gentx validator 1000000stake --chain-id=h3liax --home=${NODE_PATH}
gaiad collect-gentxs --home=${NODE_PATH}

# copy config
rm "${NODE_PATH}/config/config.toml"
cp heliax/config.toml "${NODE_PATH}/config/config.toml"

#copy app.toml
rm "${NODE_PATH}/config/app.toml"
cp heliax/app.toml "${NODE_PATH}/config/app.toml"

# generate key
gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --output json > ${NODE_PATH}/key_seed.json 2> /dev/null

# start node
screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants --pruning=nothing"
