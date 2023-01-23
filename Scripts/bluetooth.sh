#!/bin/bash

TIMEOUT=15

[[ "$(systemctl is-active bluetooth)" == 'inactive' ]] && sudo systemctl start bluetooth

ans="n"

while [[ $ans == "n" ]]; do

	bluetoothctl --timeout $TIMEOUT -- scan on

	echo "Did you find the device? (y/n)"

	read ans

done

echo "Device Address: "

while [[ -z $address ]]; do

	read address
done

bluetoothctl -- pair $address
bluetoothctl -- connect $address
