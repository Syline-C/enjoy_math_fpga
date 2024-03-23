#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -q)
docker builder prune
