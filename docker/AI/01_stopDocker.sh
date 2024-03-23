#!/bin/bash

docker_cont_name="gym_enjoy_math"
is_container_run=`docker ps -a | grep "$docker_repo_name" | awk '{print $7}'`
