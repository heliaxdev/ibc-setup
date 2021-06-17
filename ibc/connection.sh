BINARY="$HOME/ibc-setup/ibc-rs/target/release/hermes"

IBC0="h3liax"
IBC1="cosmoshub-4"

# Conn-Init 2.1

$BINARY tx raw conn-init $IBC0 $IBC1 07-tendermint-0 07-tendermint-1

# Conn-Try 2.2

$BINARY tx raw conn-try $IBC1 $IBC0 07-tendermint-1 07-tendermint-0 -s connection-0

# Conn-Ack 2.3

$BINARY tx raw conn-ack $IBC0 $IBC1 07-tendermint-0 07-tendermint-1 -d connection-0 -s connection-1

# Conn-Confirm

$BINARY tx raw conn-confirm $IBC1 $IBC0 07-tendermint-1 07-tendermint-0 -d connection-1 -s connection-0