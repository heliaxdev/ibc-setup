#variables
NAME="heliax"
PATH="~/node-${NAME}"

# create data folder
mkdir ${PATH}

# init node
gaiad init heliax-${NAME} --home=${PATH} --chain-id=${NAME}

# add keys
gaiad keys add validator --home=${PATH}
gaiad add-genesis-account $(gaiad keys show validator -a --home=${PATH}) 1000000000stake,1000000000validatortoken --home=${PATH}
gaiad gentx --name validator --home=${PATH}
gaiad collect-gentxs --home=${PATH}

# copy config
rm "${PATH}/config/config.toml"
cp stargate/genesis.json "${PATH}/config/toml.json"

# generate key
gaiad --home --home=${PATH} keys add user --keyring-backend="test" --output json > ${PATH}/key_seed.json 2> /dev/null

# start node
gaiad start --home=${PATH} --log_level=info --x-crisis-skip-assert-invariants --pruning=nothing --grpc.address="0.0.0.0:9091"