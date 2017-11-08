#!/bin/bash

UNIQUE_ID=$1
RGNAME=fabmedical-$UNIQUE_ID
BUILDAGENTVMNAME="$RGNAME-build-agent"

. ./get-ip-address-of-vm.sh $BUILDAGENTVMNAME
./log-output.sh "Starting FabMedical app..."
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS 'bash -s' < test-app.sh
read -n1 -r -p "Press any key to test app..." key
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS curl http://localhost:3001/speakers
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS curl http://localhost:3000
./log-output.sh "Finished testing FabMedical app"

NSGNAME=$BUILDAGENTVMNAME'NSG'
./log-output.sh "Opening NSG to communicate to build agent via HTTP"
az network nsg rule create --resource-group $RGNAME --nsg-name $NSGNAME --name allow-app-endpoints --priority 100 --destination-port-ranges 3000-3010
./log-output.sh "Opened NSG to communicate to build agent via HTTP"

./log-output.sh "Copy Dockerfile to content-api and content-web then build container images..."
scp -i ~/.ssh/$UNIQUE_ID content-api.Dockerfile $IP_ADDRESS:~/FabMedical/FabMedical/content-api/Dockerfile
scp -i ~/.ssh/$UNIQUE_ID index.js $IP_ADDRESS:~/FabMedical/FabMedical/content-web/data-access/.
scp -i ~/.ssh/$UNIQUE_ID content-web.Dockerfile $IP_ADDRESS:~/FabMedical/FabMedical/content-web/Dockerfile
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker build -t content-api FabMedical/FabMedical/content-api/.
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker build -t content-web FabMedical/FabMedical/content-web/.
./log-output.sh "Finished building container images."

./log-output.sh "Copy images to ACR..."
ACRNAME=acr$1
ACRLOGINSERVER=$ACRNAME'.azurecr.io'
ACRPASS=$(az acr credential show --name $ACRNAME --query "passwords[0].value" -o tsv)
ACRUSER=$(az acr credential show --name $ACRNAME --query "username" -o tsv)
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker login $ACRLOGINSERVER -u $ACRUSER -p $ACRPASS
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker tag content-web $ACRLOGINSERVER/fabmedical/content-web
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker tag content-api $ACRLOGINSERVER/fabmedical/content-api
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker tag $ACRLOGINSERVER/fabmedical/content-web:latest $ACRLOGINSERVER/fabmedical/content-web:v1
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker tag $ACRLOGINSERVER/fabmedical/content-api:latest $ACRLOGINSERVER/fabmedical/content-api:v1
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker push $ACRLOGINSERVER/fabmedical/content-web
ssh -i ~/.ssh/$UNIQUE_ID $IP_ADDRESS docker push $ACRLOGINSERVER/fabmedical/content-api
