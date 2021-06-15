# IBC Setup

Series of script to setup a IBC relayer between a stargate cosmos node and a own-testnet node.

Tested on ec2 / amazon linux.

## How to run

- *[Optional]* `./ec2.sh` to provision a machine (assume you have a valid ssh key in `key` folder). If so, go to step 4, else 2.
- `sudo yum install git -y`
- `git clone https://github.com/heliaxdev/ibc-setup`
- `cd ibc-setup`
- `./init.sh`
- `source ~/.bash_profile`
- `./run.sh`
- As soon as the stargate node is ready, run `./ibc.sh`

## Issues

- Working out the issues here: https://github.com/informalsystems/ibc-rs/issues/697
