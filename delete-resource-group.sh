#!/bin/bash
RGTODELETE=$1
echo "Deleting resource group $RGTODELETE..."
az group delete --name $RGTODELETE
echo "Finished deleting resource group $RGTODELETE"
