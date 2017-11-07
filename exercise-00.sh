#!/bin/bash
if [ -z $1 ]
then
    echo "Usage: ./exercise-00.sh UniqueIdentifier [location]"
    exit
fi

if [ -z $2 ]
then
    LOCATION=australiasoutheast
else
    LOCATION=$2
fi

RGNAME=fabmedical-$1

./log-output.sh "Started provisioning exercise-00..."

. ./create-ssh-key.sh $1
. ./set-resource-group-name-variable.sh $RGNAME
. ./set-resource-group-location-variable.sh $LOCATION
. ./create-resource-group.sh
. ./create-build-server.sh $1
. ./get-ip-address-of-vm.sh $BUILDAGENTVMNAME
. ./configure-build-server.sh $1 $IP_ADDRESS
. ./create-acr.sh $1
. ./create-storage-account.sh $RGNAME stor$1
. ./create-blob-container.sh $RGNAME stor$1 registrycredentials
. ./create-acs.sh $1

./log-output.sh "Finished provisioning exercise-00."