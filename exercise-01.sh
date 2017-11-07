#!/bin/bash

UNIQUE_ID=$1
RGNAME=fabmedical-$UNIQUE_ID
BUILDAGENTVMNAME="$RGNAME-build-agent"

. ./get-ip-address-of-vm.sh $BUILDAGENTVMNAME
./log-output.sh "Getting FabMedical environment..."
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS curl -L -o FabMedical.tgz http://bit.ly/2k5aZdg
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS mkdir FabMedical
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS tar -C FabMedical -xzf FabMedical.tgz
./log-output.sh "Finished getting FabMedical environment"
