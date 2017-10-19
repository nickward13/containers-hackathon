#!/bin/bash
RGTODELETE=$1
./log-output.sh "Deleting resource group $RGTODELETE..."
az group delete --name $RGTODELETE
./log-output.sh "Finished deleting resource group $RGTODELETE"
