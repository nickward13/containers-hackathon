#!/bin/bash

if [ -z "$RGNAME" ]
then
    echo "Please set RGNAME variable to the name of the resource group to create"
    exit
fi

VMNAME=$1

./log-output.sh "Exporting IP_ADDRESS for $VMNAME"
export IP_ADDRESS=$(az vm list-ip-addresses --resource-group $RGNAME --name $VMNAME \
    --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
./log-output.sh "Exported IP_ADDRESS for $VMNAME is $IP_ADDRESS"
