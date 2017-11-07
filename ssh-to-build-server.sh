#!/bin/bash
./log-output.sh "Connecting to $1 via ssh..."
ssh -i ~/.ssh/id_rsa $1
./log-output.sh "Connected to $1 via ssh."
