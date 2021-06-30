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

# import key (requires interaction) -> we need to import an address with some coin 
OUTPUT=$(gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --recover --output json)
echo $OUTPUT > ${NODE_PATH}/key_seed.json 2> /dev/null
echo "Reinput mnemonic..."
read MNEMONIC
KEY_SEED=$(jq --arg MNEMONIC "$MNEMONIC" '{ "mnemonic": $MNEMONIC } + .' ${NODE_PATH}/key_seed.json)
echo $KEY_SEED > ${NODE_PATH}/key_seed.json


read -p "Do you already have a snapshot folder in home? " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf "${NODE_PATH}/data"
    mv ~/data $NODE_PATH
    cd ~/ibc-setup
else 
    # download a snapshot of the chain
    rm -rf "${NODE_PATH}/data"
    DATE=`date +%Y%m%d`
    FILENAME="cosmoshub-4-default.${DATE}.0510.tar.lz4"
    cd $NODE_PATH
    aria2c -x5 https://get.quicksync.io/$FILENAME
    lz4 -d $FILENAME | tar xf -
    rm $FILENAME
    cd ~/ibc-setup
fi

# start node
screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants"
