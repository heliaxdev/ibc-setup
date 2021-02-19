#!/bin/bash

for SCRIPT_NAME in "stargate" "heliax" "ibc"
do
	./${SCRIPT_NAME}.sh
done

./ibc/run.sh