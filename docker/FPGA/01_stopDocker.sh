#!/bin/bash

docker_cont_name="fpga_enjoy_math"
is_container_run=`docker ps -a | grep "$docker_cont_name" | awk '{print $7}'`

docker stop  $docker_cont_name
