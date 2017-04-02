#!/bin/sh

docker  ps  -a

docker  run  \
  --detach  \
  --env-file=./docker/env.list  \
  --hostname=localhost  \
  --interactive=true  \
  --name=nginx  \
  --publish=10080:80  \
  --restart=always  \
  --tty=true  \
  --volume=$(pwd)/data:/data  \
  --volume=$(pwd)/docker/nginx.conf:/etc/nginx/nginx.conf  \
  zanner/nginx:latest

# more options:
#
#  --cpus="2"  \
#  --memory="256m"  \
#  --memory-swap="512m"  \
#  --storage-opt size=2G  \
