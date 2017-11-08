#!/bin/bash

UNIQUE_ID=$1
RGNAME=fabmedical-$UNIQUE_ID
ACS_NAME=acs$UNIQUE_ID

az acs scale --resource-group $RGNAME --name $ACS_NAME --new agent-count 3

# install marathon-lb in the DCOS cluster via the management portal

# get IP address of agent load balancer in Azure
AGENTLBIP=$(az network public-ip list --resource-group $RGNAME --query "[?contains(name,'dcos-agent')].{ipAddress:ipAddress}" -o tsv)
./log-output.sh "Agent load balancer public IP address is $AGENTLBIP"

# update details in marathon-web-marathon-lb.json
# particularly labels.HAPROXY_0_VHOST, container.docker.image, fetch.uri

curl -X POST -d @marathon-web-marathon-lb.json -H "Content-type: application/json" http://localhost:85/marathon/v2/apps
