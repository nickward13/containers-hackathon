# containers-hackathon

This repository is for use with the Microsoft Cloud Workshop for containers and devops.  Technologies explored include Azure Container Services, Azure Container Registry, DC/OS, Docker Containers, Chef.

Pre-requisites on your machine include:
- git
- Azure CLI 2
    - install or update first with brew install azure-cli or brew update / brew upgrade ref.: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

To use this repository to reproduce the hackathon:
- run each exercise-*.sh to complete each exercise in turn.  For example, execute exercise-00.sh to complete the 00 exercise of the hackathon.
- in turn, each exercise-*.sh script uses utility scripts to create the hackathon environment
- run delete-hackathon.sh to remove the hackathon from your Azure subscription
