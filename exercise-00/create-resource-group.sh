#!/bin/bash          
if [ -z "$RGNAME" ]
then
    echo "Please set RGNAME variable to the name of the resource group to create"
    exit
fi

if [ -z "$RGLOCATION" ]
then
    echo "Please set RGLOCATION variable to the location of the resource group to create"
    exit
fi

az group create --name $RGNAME --location $RGLOCATION
