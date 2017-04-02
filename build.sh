#!/bin/sh

docker  build  \
  --compress  \
  --tag="zanner/nginx":latest  \
  .

docker images
