#!/bin/bash
UNIQUE_ID=$1
IP_ADDRESS=$2
./log-output.sh "Installing build tools on $IP_ADDRESS..."
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS sudo apt-get update
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS sudo apt install docker.io curl nodejs npm
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS sudo apt-get upgrade
./log-output.sh "Finished installing build tools on $1."
