#!/bin/bash
if [ -z $1 ]
then
    echo "Usage: ./delete-hackathon.sh UniqueIdentifier"
    exit
fi

RGNAME=fabmedical-$1
./log-output.sh "Deleting hackathon for $1..."
./delete-resource-group.sh $RGNAME
./rm -i ~/.ssh/$1*
./log-output.sh "Deleted hackathon for $1."
