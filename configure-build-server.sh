#!/bin/bash
UNIQUE_ID=$1
IP_ADDRESS=$2
./log-output.sh "Starting configuration of build server..."
./install-build-tools-over-ssh.sh $UNIQUE_ID $IP_ADDRESS
./add-user-to-docker-group-over-ssh.sh $UNIQUE_ID $IP_ADDRESS
./log-output.sh "Finished configuration fo build server."
