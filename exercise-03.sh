#!/bin/bash

UNIQUE_ID=$1
RGNAME=fabmedical-$UNIQUE_ID
BUILDAGENTVMNAME="$RGNAME-build-agent"
STORAGEACCOUNTNAME=stor$UNIQUE_ID

. ./get-ip-address-of-vm.sh $BUILDAGENTVMNAME

ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS tar czf docker.tar.gz .docker
scp -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS:docker.tar.gz .

STORAGEACCOUNTKEY=$(az storage account keys list --resource-group $RGNAME --account-name $STORAGEACCOUNTNAME --query "[0].value" -o tsv)
az storage blob upload --account-name $STORAGEACCOUNTNAME --account-key $STORAGEACCOUNTKEY --container-name registrycredentials --name docker.tar.gz --file ./docker.tar.gz

ACS_NAME=acs$UNIQUE_ID
LINUXADMINUSERNAME=$(az acs show --resource-group $RGNAME --name $ACS_NAME --query "linuxProfile.adminUsername" -o tsv)
MASTERFQDN=$(az acs show --resource-group $RGNAME --name $ACS_NAME --query "masterProfile.fqdn" -o tsv)

# forward local port to ACS management port to be able to access DCOS management dashboard over ssh
# ssh -L 85:localhost:80 -N -i ~/.ssh/$UNIQUE_ID $LINUXADMINUSERNAME@$MASTERFQDN -p 2200

ACRNAME=acr$1
ACRLOGINSERVER=$ACRNAME'.azurecr.io'

# update the content of the .json files to point to your images; 
# specifically the fetch.uri and container.docker.image values
curl -X POST -d @marathon-api.json -H "Content-type: application/json" http://localhost:85/marathon/v2/apps
curl -X POST -d @marathon-web.json -H "Content-type: application/json" http://localhost:85/marathon/v2/apps

# get agent fully qualified domain name, to be able to browse to running app in container
AGENTFQDN=$(az acs show --resource-group $RGNAME --name $ACS_NAME --query "agentPoolProfiles[0].fqdn" -o tsv)
./log-output.sh "Agent URL for browing app is $AGENTFQDN."

