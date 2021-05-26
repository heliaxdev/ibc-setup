#!/bin/bash

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
source $HOME/.cargo/env

# install git, htop
sudo yum install -y git
sudo yum install -y htop

# install golang
sudo yum install golang -y

# install openssl-dev
sudo yum install openssl-devel -y

# install docker
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on

# update bash profile
. ~/.bash_profile

# install ibc
git clone https://github.com/informalsystems/ibc-rs.git
cd ibc-rs
git checkout v0.3.2
cargo build --release --bin hermes
alias hermes='$HOME/ibc-setup/ibc-rs/target/release/hermes'

# install gaia
mkdir -p $HOME/go/bin
echo "export PATH=$PATH:$(go env GOPATH)/bin" >> ~/.bash_profile
source ~/.bash_profile

git clone https://github.com/cosmos/gaia.git ~/go/src/github.com/cosmos/gaia
cd ~/go/src/github.com/cosmos/gaia
git checkout v4.2.1
make install

# update bash profile
. ~/.bash_profile
