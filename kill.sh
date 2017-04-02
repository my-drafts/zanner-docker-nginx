#!/bin/sh

docker rm -f nginx 2>/dev/null 
docker rmi -f zanner/nginx 2>/dev/null

docker images && docker ps -a

