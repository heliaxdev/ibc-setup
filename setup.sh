#!/bin/bash

for NODE in "stargate" "heliax" "ibc"
do
	screen -d -m -S ${NODE} "${NODE}/${NODE}.sh"
done

./ibc/run.sh