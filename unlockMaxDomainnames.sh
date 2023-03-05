#!/bin/bash

#
# Nginx Proxy Manager limits the max domain names to 15 per cert.
# To have more than 15, which I need for my mail server, this has first to be unlocked.
#

# Variables
dockerId=""
filePath="/app/schema/definitions.json"

# Get container ID
dockerId=$(docker container ls --all --quiet --filter "name=npm")

echo "Setting max from 15 to 50"
# Replace 15 to 50
docker exec $dockerId sed -i "s/\"maxItems\"\:\ 15/\"maxItems\"\:\ 50/g" $filePath

echo "Restarting container"
# Container needs to be restarted to take effect
docker restart $dockerId

# End
exit 0
