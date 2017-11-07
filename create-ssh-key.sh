#!/bin/bash
./log-output.sh "Creating SSH key $1..."
ssh-keygen -q -N "" -f ~/.ssh/$1
./log-output.sh "Finished creating SSH key $1."