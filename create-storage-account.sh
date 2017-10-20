#!/bin/bash
RGNAME=$1
NAME=$2
./log-output.sh "Creating storage account $NAME in $RGNAME..."
az storage account create --resource-group $RGNAME --name $NAME --sku Standard_LRS --https-only false
./log-output.sh "Finished creating storage account $NAME in $RGNAME."
