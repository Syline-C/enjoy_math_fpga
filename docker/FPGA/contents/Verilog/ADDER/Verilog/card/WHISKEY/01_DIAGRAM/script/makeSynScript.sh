#!/bin/bash

rtl_list=($(ls $RTL_PATH))

echo "start"
for rtl in "${rtl_list[@]}"; do
	filename=$(echo $rtl | awk -F "." '{print $1}')
	scriptname=$filename.ys
	echo "read_verilog "$RTL_PATH$rtl >> ./script/yosys/$scriptname
	echo "proc" >> ./script/yosys/$scriptname
	echo "synth" >> ./script/yosys/$scriptname
	echo "opt_clean" >> ./script/yosys/$scriptname

	echo "show -format dot -prefix "$PRJ_DIR"/01_DIAGRAM/DOT/"$filename >> ./script/yosys/$scriptname
	echo "write_json "$PRJ_DIR"/01_DIAGRAM/JSON/"$filename".json" >> ./script/yosys/$scriptname
done

