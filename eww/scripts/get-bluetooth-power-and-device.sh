#!/bin/sh

powered=$(bluetoothctl show | grep "Powered: no")

if [ "$powered" == "" ]; then
	status="true"
	connected_device=$(bluetoothctl info | grep "Name" | cut -c 8-)
else
	status="false"
	connected_device=""
fi

echo "[ \"$status\" , \"$connected_device\" ]"