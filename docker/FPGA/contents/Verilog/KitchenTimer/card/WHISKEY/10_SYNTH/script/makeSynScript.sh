#!/bin/bash

rtl_list=($(ls $RTL_PATH))

for rtl in "${rtl_list[@]}"; do
	echo "read_verilog "$RTL_PATH$rtl >> ./script/yosys/synthesis.ys
done

echo "hierarchy -check -top "$DESIGN_NAME >> ./script/yosys/synthesis.ys

echo "proc" >> ./script/yosys/synthesis.ys

echo "synth" >> ./script/yosys/synthesis.ys

echo "abc" >> ./script/yosys/synthesis.ys
echo "opt_clean" >> ./script/yosys/synthesis.ys
echo "stat" >> ./script/yosys/synthesis.ys

echo "show -format dot -prefix "$PRJ_DIR"/11_AFT_SYN_DIAGRAM/DOT/"$DESIGN_NAME >> ./script/yosys/synthesis.ys
echo "write_json "$PRJ_DIR"/11_AFT_SYN_DIAGRAM/JSON/"$DESIGN_NAME".json" >> ./script/yosys/synthesis.ys
echo "write_verilog ./"$DESIGN_NAME"_SYN.v" >> ./script/yosys/synthesis.ys
