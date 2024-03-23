#!/bin/bash


current_dir="/home/conda"

. /root/miniconda3/etc/profile.d/conda.sh 
conda init bash

is_racing_exist=`conda env list | grep car_racing | awk '{print $1}'`
is_mario_exist=`conda env list | grep super_mario | awk '{print $1}'`

if [ ! -n "$is_racing_exist" ]; then
	conda env create -n car_racing --file $current_dir/card/python/yaml/conda_carRacing.yaml
fi

if [ ! -n "$is_mario_exist" ]; then
	conda env create -n super_mario --file $current_dir/card/python/yaml/conda_superMario.yaml
fi


if [ ! -d car_racing/raw ]; then 
	rm -rf car_racing
	mkdir -p car_racing/raw
	cd car_racing/raw
	git clone https://github.com/Farama-Foundation/Gymnasium.git
fi

cd $current_dir

if [ ! -d superMario ]; then
	rm -rf superMario
	mkdir -p superMario/raw
	cd superMario/raw
	git clone https://github.com/Kautenja/gym-super-mario-bros.git
fi

cd $current_dir

if [ ! -d NES ]; then
	rm -rf NES
	mkdir -p NES/raw
	cd NES/raw
	git clone https://github.com/Kautenja/nes-py.git
fi



cd $current_dir

echo ""
echo "================================="
conda env list
echo "================================="
echo ""

