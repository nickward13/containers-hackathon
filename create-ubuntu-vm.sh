#!/bin/bash
if [ -z "$RGNAME" ]
then
    echo "Please set RGNAME variable to the name of the resource group to create"
    exit
fi

VMNAME=$1

./log-output.sh "Creating ubuntu server VM with name $VMNAME in resource group $RGNAME..."
az vm create --name $VMNAME --resource-group $RGNAME --image ubuntults --size Standard_DS2 --ssh-key-value @~/.ssh/id_rsa.pub
./log-output.sh "Created ubuntu server VM with name $VMNAME in resource group $RGNAME"
