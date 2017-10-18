#!/bin/bash
if [ -z "$RGNAME" ]
then
    echo "Please set RGNAME variable to the name of the resource group to create"
    exit
fi

export BUILDAGENTVMNAME="$RGNAME-build-agent"

echo "Launching script to build agent with name $BUILDAGENTVMNAME..."
./create-ubuntu-vm.sh $BUILDAGENTVMNAME
echo "Finished exeucting script to build agent with name $BUILDAGENTVMNAME."
