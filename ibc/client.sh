BINARY="$HOME/ibc-setup/ibc-rs/target/release/hermes"

IBC0="h3liax"
IBC1="cosmoshub-4"

# Setup identifiers 1.1

$BINARY tx raw create-client $IBC0 $IBC1
$BINARY tx raw create-client $IBC1 $IBC0

# Update client 1.2

$BINARY tx raw update-client $IBC0 07-tendermint-0
$BINARY tx raw update-client $IBC1 07-tendermint-1