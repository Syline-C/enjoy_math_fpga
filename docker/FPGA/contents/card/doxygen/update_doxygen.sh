#!/bin/bash


doxy_path="/home/card/doxygen"
doxygen $doxy_path/Doxyfile_python

is_nginx_run=`systemctl status nginx | grep -o active`

if [ -n "$is_nginx_run" ]; then
	systemctl start nginx
else
	systmectl restart nginx
fi
