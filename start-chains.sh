# start heliax chain
NAME="heliax"
NODE_PATH="$HOME/node-${NAME}"
CHAIN_ID=h3liax

screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=error --x-crisis-skip-assert-invariants"

# start cosmoshub-4 chain
NAME="stargate"
NODE_PATH="$HOME/node-${NAME}"
CHAIN_ID=stargate

screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=error --x-crisis-skip-assert-invariants"