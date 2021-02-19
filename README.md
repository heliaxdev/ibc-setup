# IBC Setup

Series of script to setup a IBC relayer between a stargate cosmos node and a own-testnet node.

Tested on ec2 / amazon linux.

## How to run

- `cd setup-ibc`
- `./init.sh`
- `source ~/.bash_profile`
- `./run.sh`

## Issues

- Somehow, when running `hermes channel handshake ibc-0 ibc-1 transfer transfer`, it ends with the following error: 
  ```{"status":"error","result":"chain runtime/handle error: Light client supervisor error for chain id heliax: empty witness list"}```
