#!/bin/bash
UNIQUE_ID=$1
IP_ADDRESS=$2
./log-output.sh "Adding user to docker group on $IP_ADDRESS..."
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS sudo usermod -a -G docker $USER
./log-output.sh "Finished adding user to docker group on $IP_ADDRESS."
