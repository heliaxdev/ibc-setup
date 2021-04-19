#!/bin/bash

BINARY="$HOME/ibc-setup/ibc-rs/target/release/hermes"

# Setup identifiers

$BINARY tx raw create-client heliax stargate

# `07-tendermint-0` is always like this if running for the first time
$BINARY tx raw conn-init ibc-1 ibc-0 07-tendermint-0 07-tendermint-0

# same for connection-0
$BINARY tx raw chan-open-init ibc-1 ibc-0 connection-0 transfer transfer

# Configuring client

$BINARY tx raw create-client stargate heliax

# to obtain `07-tendermint-1` client identity, we need to run it two times
$BINARY tx raw create-client heliax stargate
$BINARY tx raw create-client heliax stargate

$BINARY tx raw update-client ibc-0 07-tendermint-0

$BINARY tx raw update-client ibc-1 07-tendermint-1
