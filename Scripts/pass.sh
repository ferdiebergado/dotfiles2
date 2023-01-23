#!/bin/bash

arr=()

for d in "$(ls -d ~/.password-store/*)"; do
	arr+="$(basename "$d")\n"
done

echo -e "${arr[*]}" | bemenu
