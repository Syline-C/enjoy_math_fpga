#!/bin/bash

source /home/card/powerline/powerlineSetting.sh
source /home/card/python/script/run_conda.sh
source /home/card/doxygen/run_doxygen.sh

cd /home/fpga

if [ -L /home/fpga/superMario ]; then 
	rm -rf /home/fpga/superMario  
	ln -s /home/conda/superMario/Enjoy_Math/ /home/fpga/superMario 
else 
	ln -s /home/conda/superMario/Enjoy_Math/ /home/fpga/superMario  
fi

if [ -L /home/conda/superMario/update_doxygen ]; then 
	rm -rf /home/conda/superMario/update_doxygen  
	ln -s /home/card/doxygen/update_doxygen.sh /home/conda/superMario/update_doxygen 
else 
	ln -s /home/card/doxygen/update_doxygen.sh /home/conda/superMario/update_doxygen 
fi

cp /home/card/nginx/conf/nginx.conf /etc/nginx/conf.d

exec /bin/bash
