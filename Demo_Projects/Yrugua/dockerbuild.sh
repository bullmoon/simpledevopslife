#!/bin/bash
clear
DOCKERHUB="bulldrive"
IMGNAME="yrugua"
export TAG="dev"

docker --log-level "debug" build --tag $DOCKERHUB/$IMGNAME:$TAG .

echo "***********************"
echo "image created:"
echo $DOCKERHUB/$IMGNAME:$TAG
echo "***********************"

# Stop the previous container
# docker stop $(docker ps --format '{{.Names}}')

# Remove all inactive containers
# docker rm $(docker ps -aq)

# Run the built container
docker run -d -p 9003:9003 $DOCKERHUB/$IMGNAME:$TAG

# Debug
# docker exec $(docker ps --latest --format '{{.Names}}') netstat -l
docker logs $(docker ps --latest --format '{{.Names}}')