#!/bin/bash
if [ -z $1 ]
then
    echo "Usage: ./delete-hackathon.sh UniqueIdentifier"
    exit
fi

RGNAME=fabmedical-$1
./log-output.sh "Launching script to delete resource group $RGNAME..."
./delete-resource-group.sh $RGNAME
./log-output.sh "Finished script to delete resource group $RGNAME."
