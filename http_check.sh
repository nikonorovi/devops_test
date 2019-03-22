#!/bin/bash
status=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8091/up)

if [[ "$status" -eq 200 ]];then
	exit 0
else
	exit 2
fi
