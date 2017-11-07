#!/bin/bash
ACS_NAME=acs$1
./log-output.sh "Creating Azure Container Service named $ACS_NAME..."
az acs create --output table --resource-group $RGNAME --name $ACS_NAME --ssh-key-value @~/.ssh/$1.pub --orchestrator-type DCOS --dns-prefix fabmedical-$1 --admin-username adminfabmedical --agent-count 2 --agent-vm-size Standard_DS2
./log-output.sh "Finished creating Azure Container Service named $ACS_NAME."
