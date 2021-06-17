#!/bin/bash

# variables
NAME="heliax"
NODE_PATH="$HOME/node-${NAME}"

# create data folder
mkdir ${NODE_PATH}

# init node
gaiad init heliax-${NAME} --home=${NODE_PATH} --chain-id=h3liax

STAKE=1000000000stake
SAMOLEANS=100000000samoleans
USER_COINS="${STAKE},${SAMOLEANS}"

# add keys
gaiad keys add validator --home=${NODE_PATH} --keyring-backend="test" --output json > ${NODE_PATH}/validator_seed.json 2> /dev/null

OUTPUT=$(gaiad --home=${NODE_PATH} keys add user --keyring-backend="test" --recover --output json)
echo $OUTPUT > ${NODE_PATH}/key_seed.json 2> /dev/null
read MNEMONIC
KEY_SEED=$(jq --arg MNEMONIC "$MNEMONIC" '{ "mnemonic": $MNEMONIC } + .' ${NODE_PATH}/key_seed.json)
echo $KEY_SEED > ${NODE_PATH}/key_seed.json

gaiad add-genesis-account $(gaiad keys show validator -a --keyring-backend="test" --home=${NODE_PATH}) $STAKE --home=${NODE_PATH}
gaiad add-genesis-account $(gaiad keys show user -a --keyring-backend="test" --home=${NODE_PATH}) $USER_COINS --home=${NODE_PATH}
gaiad gentx validator 1000000stake --chain-id=h3liax --home=${NODE_PATH} --keyring-backend="test"
gaiad collect-gentxs --home=${NODE_PATH}

# copy config
rm "${NODE_PATH}/config/config.toml"
cp heliax/config.toml "${NODE_PATH}/config/config.toml"

#copy app.toml
rm "${NODE_PATH}/config/app.toml"
cp heliax/app.toml "${NODE_PATH}/config/app.toml"

# gaiad tx bank send validator cosmos16j8g8ye76ccuu3nvpquk6wdqcuaejhy2amvqdh 100stake  --home=${NODE_PATH} --chain-id=h3liax --keyring-backend="test"
# gaiad keys list --home=${NODE_PATH} --chain-id=h3liax --keyring-backend="test"

# start node
screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants"
