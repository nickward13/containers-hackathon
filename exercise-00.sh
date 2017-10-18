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

. ./set-resource-group-name-variable.sh fabmedical-$1
. ./set-resource-group-location-variable.sh $LOCATION
. ./create-resource-group.sh
. ./create-build-server.sh
. ./get-ip-address-of-vm.sh $BUILDAGENTVMNAME