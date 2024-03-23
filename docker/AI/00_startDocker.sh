#!/bin/bash

docker_cont_name="gym_enjoy_math"
docker_repo_name="gym_repo"
current_dir=`pwd`

if [ -d ./contents/card ]; then
	rm -rf ./contents/card 
	cp -r ./card ./contents
else
	cp -r ./card ./contents
fi

xserver_ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
socat_pid=`lsof -i TCP:6000 | awk '{print $2}' | grep -ve '[A-Z]'`

is_image_maked=`docker images | grep "$docker_repo_name" | awk '{print $1}'`
is_container_run=`docker ps -a --format "{{.Image}},{{.Status}}" | grep $docker_repo_name | awk -F "," '{print $2}' | awk '{print $1}'`

img_Flag=0
cont_Flag=0

if [ -n "$socat_pid" ]; then
	echo "kill socat PID"
	kill -9 $socat_pid
fi

defaults write org.xquartz.X11 enable_iglx -bool true

open -a XQuartz
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

if [ ! -n "$is_image_maked" ]; then
	docker build --platform linux/amd64 --tag $docker_repo_name .
	img_Flag=1
elif [ "$is_image_maked" = "$docker_repo_name" ]; then
	img_Flag=1
else
	img_Flag=0
fi


is_image_maked=`docker images | grep "$docker_repo_name" | awk '{print $1}'`
if [ "$img_Flag" = 1 ]; then
		if [ -n "$is_image_maked" ]; then
			if [ ! -n "$is_container_run" ]; then
				docker run -d -it \
					-e DISPLAY=$xserver_ip:0 \
					-v $current_dir/contents:/home/conda \
					-v /tmp/.X11-unix:/tmp/.X11-unix \
					-p 8888:8888 \
					--name $docker_cont_name $docker_repo_name /bin/bash

				#is_container_run=`docker ps -a | grep "$docker_repo_name" | awk '{print $7}'`
				is_container_run=`docker ps -a --format "{{.Image}},{{.Status}}" | grep $docker_repo_name | awk -F "," '{print $2}' | awk '{print $1}'`
			fi
		fi
fi

if [ -n "$is_container_run"  ]; then
	if [ "$is_container_run" = "Exited" ] || [ "$is_container_run" = "Created" ]; then
		docker start $docker_cont_name
		docker attach $docker_cont_name
	else
		docker attach $docker_cont_name
	fi
fi
