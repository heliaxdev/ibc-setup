BINARY="$HOME/ibc-setup/ibc-rs/target/release/hermes"

IBC0="heliax"
IBC1="stargate"

# Chan-Open-Init 3.1

$BINARY tx raw chan-open-init $IBC0 $IBC1 connection-0 transfer transfer -o UNORDERED

# Chan-Open-Try 3.2

$BINARY tx raw chan-open-try $IBC1 $IBC0 connection-1 transfer transfer -s channel-0

# Chan-Open-Ack 3.3

$BINARY tx raw chan-open-ack $IBC0 $IBC1 connection-0 transfer transfer -d channel-0 -s channel-1

# Chan-Open-Confirm

$BINARY tx raw chan-open-confirm $IBC1 $IBC0 connection-1 transfer transfer -d channel-1 -s channel-0