#!/bin/bash

doxy_path="/home/card/doxygen"


if [ ! -d /home/doxygen ]; then
	mkdir -p /home/doxygen/python
	doxygen $doxy_path/Doxyfile_python
fi

is_nginx_run=`systemctl status nginx | grep -o active`

if [ -n "$is_nginx_run" ]; then
	systemctl start nginx
else
	systmectl restart nginx
fi
