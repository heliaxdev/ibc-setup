#!/bin/bash

# variables
NAME="heliax"
NODE_PATH="$HOME/node-${NAME}"
CHAIN_ID=h3liax

# create data folder
mkdir ${NODE_PATH}

# init node
gaiad init heliax-$NAME --home=$NODE_PATH --chain-id=$CHAIN_ID

STAKE=1000000000stake
SAMOLEANS=100000000samoleans
USER_COINS="${STAKE},${SAMOLEANS}"

# add keys
gaiad keys add validator --home=$NODE_PATH --keyring-backend="test" --output json > $NODE_PATH/validator_seed.json 2> /dev/null
gaiad keys add user --home=$NODE_PATH --keyring-backend="test" --output json > $NODE_PATH/key_seed.json 2> /dev/null

VALIDATOR_ADDRESS=$(gaiad keys show validator -a --keyring-backend="test" --home=$NODE_PATH)
USER_ADDRESS=$(gaiad keys show user -a --keyring-backend="test" --home=$NODE_PATH)

gaiad add-genesis-account $VALIDATOR_ADDRESS $STAKE --home=$NODE_PATH
gaiad add-genesis-account $USER_ADDRESS $USER_COINS --home=$NODE_PATH
gaiad gentx validator $STAKE --chain-id=$CHAIN_ID --home=$NODE_PATH --keyring-backend="test" &> /dev/null
gaiad collect-gentxs --home=$NODE_PATH &> /dev/null

# copy config
rm "${NODE_PATH}/config/config.toml"
cp heliax/config.toml "${NODE_PATH}/config/config.toml"

#copy app.toml
rm "${NODE_PATH}/config/app.toml"
cp heliax/app.toml "${NODE_PATH}/config/app.toml"

# start node
screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants"

echo "List of keys..."
gaiad keys list --home=$NODE_PATH --keyring-backend="test"

RPC_ADDR="tcp://localhost:26357"
echo "Balance for validator (${VALIDATOR_ADDRESS})"
# gaiad query bank balances $VALIDATOR_ADDRESS --home=$NODE_PATH --chain-id=$CHAIN_ID -> this doesn't work (?) weird
gaiad --node "$RPC_ADDR" query bank balances $VALIDATOR_ADDRESS --log_level error

echo "Balance for user (${USER_ADDRESS})"
# gaiad query bank balances $USER_ADDRESS --home=$NODE_PATH --chain-id=$CHAIN_ID -> this doesn't work (?) weird
gaiad --node "$RPC_ADDR" query bank balances $USER_ADDRESS --log_level error
