#!/bin/bash


echo ./$VERILOG_TB_NAME >> list.txt 

rtl_list=($(ls $RTL_PATH))

for rtl in "${rtl_list[@]}"; do
	echo $RTL_PATH$rtl >> list.txt
done

mv list.txt $PRJ_DIR/00_COMPILE  > /dev/null