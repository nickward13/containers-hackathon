#!/bin/bash
RGNAME=$1
NAME=$2
CONTNAME=$3
./log-output.sh "Creating container $CONTNAME in $NAME in $RGNAME..."
ACCOUNTKEY=$(az storage account keys list --resource-group $RGNAME --account-name $NAME --query "[0].value" -o tsv)
az storage container create --account-name $NAME --account-key $ACCOUNTKEY --name $CONTNAME --public-access container
./log-output.sh "Finished creating container $CONTNAME in $NAME in $RGNAME."
