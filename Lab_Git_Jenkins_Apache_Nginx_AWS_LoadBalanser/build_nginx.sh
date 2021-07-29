!#/bin/bash

docker --debug build -f dockerfile_nginx -t bullhorn/nginx-proxy . 
docker --debug push bullhorn/nginx-proxy
sleep 5
