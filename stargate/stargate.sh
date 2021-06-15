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

# copy config.toml
rm "${NODE_PATH}/config/config.toml"
cp stargate/config.toml "${NODE_PATH}/config/config.toml"

#copy app.toml
rm "${NODE_PATH}/config/app.toml"
cp stargate/app.toml "${NODE_PATH}/config/app.toml"

# generate key
# gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --output json > ${NODE_PATH}/key_seed.json 2> /dev/null 

# import key (requires interaction)
gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --recover

# download a snapshot of the chain 15/06/2021
rm -rf "${NODE_PATH}/data"
FILENAME="cosmoshub-4-default.20210615.0510.tar.lz4"
cd $NODE_PATH
aria2c -x5 https://get.quicksync.io/$FILENAME
lz4 -d $FILENAME | tar xf -
cd ~/ibc-setup

# start node
screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants"
