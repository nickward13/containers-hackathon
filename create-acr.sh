#!/bin/bash
ACR_NAME=acr$1
./log-output.sh "Creating Azure Container Registry named $ACR_NAME..."
az acr create --output table --name $ACR_NAME --resource-group $RGNAME --sku Basic --admin-enabled true
./log-output.sh "Finished creating Azure Container Registry named $ACR_NAME."
