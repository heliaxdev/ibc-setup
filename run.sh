#!/bin/bash

for SCRIPT_NAME in "stargate" "heliax" "ibc"
do
	./${SCRIPT_NAME}/${SCRIPT_NAME}.sh
done