# IBC Setup

Series of script to setup a IBC relayer between a stargate cosmos node and a own-testnet node.

Tested on ec2 / amazon linux.

## How to run

- `cd setup-ibc`
- `./init.sh`
- `source ~/.bash_profile`
- `./setup.sh`

## Issues

- Somehow, when running `hermes channel handshake ibc-0 ibc-1 transfer transfer`, it ends with the following error: 
  ```{"status":"error","result":"chain runtime/handle error: Light client instance error for rpc address tcp://localhost:26657: I/O error: fetched validator set is invalid: proposer with address '52E1646134432BF9532B4881C6ED32E40AE5A2DD' not found in validator set"}```
