# start heliax chain
NAME="heliax"
NODE_PATH="$HOME/node-${NAME}"
echo "Starting ${NAME} node (${NODE_PATH})..."

screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants"

# start cosmoshub-4 chain
NAME="stargate"
NODE_PATH="$HOME/node-${NAME}"
echo "Starting ${NAME} node (${NODE_PATH})..."

screen -d -m -S ${NAME} bash -c "gaiad start --home=${NODE_PATH} --log_level=info --x-crisis-skip-assert-invariants"