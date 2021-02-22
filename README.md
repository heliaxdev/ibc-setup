# IBC Setup

Series of script to setup a IBC relayer between a stargate cosmos node and a own-testnet node.

Tested on ec2 / amazon linux.

## How to run

- `cd setup-ibc`
- `./init.sh`
- `source ~/.bash_profile`
- `./run.sh`
- As soon as the stargate node is ready, run `./ibc.sh`

## Issues

- Somehow, when running `hermes channel handshake stargate heliax transfer transfer`, it ends with the following error: 
  ```
  {"status":"error","result":"chain runtime/handle error: Light client instance error for rpc address tcp://localhost:26657: invalid light block: invalid validator set: header_validators_hash=862A9C43A9A29FC6D508352B056A738DB35B3F96F0FA02F0DA2FC1ED8035A55C validators_hash=0198C4156F82C8E0B11C23A24F43FEDE7D92D9146E64FD5D37C5ED3360F53AA9"}
```
