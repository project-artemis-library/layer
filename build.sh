#!/usr/bin/env bash

set -xeuo pipefail

docker image build -f ./Dockerfile -t $1:latest ./$1
docker container run --name $1 $1:latest
mkdir -p ./layers/$1
docker container cp $1:/tmp/layer/python ./layers/$1/
docker container rm $1
docker image rm $1:latest