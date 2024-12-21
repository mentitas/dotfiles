#!/bin/sh


# bluetoothctl devices | cut -f2 -d ' ' | while read uuid; do bluetoothctl info $uuid; done | grep -e "Device\|Connected\|Name\|Paired"


bluetoothctl devices |
{	
	devices='[]'
	while read line ; do

		address=$(echo $line | cut -f 2 -d ' ') 
		
		name=$(     bluetoothctl info $address | grep -e "Name"      | cut -f 1 -d ' ' --complement)
		connected=$(bluetoothctl info $address | grep -e "Connected" | cut -f 2 -d ' ')
		paired=$(   bluetoothctl info $address | grep -e "Paired"    | cut -f 2 -d ' ')
		battery=$(  bluetoothctl info $address | grep -e "Battery"   | cut -f 4 -d ' ' | tr -d "(" | tr -d ")")

		#ughh que asco
		if [ "$connected" == "yes" ]; then
			connected=true
		else
			connected=false
		fi

		if [ "$paired" == "yes" ]; then
			paired=true
		else
			paired=false
		fi

		#name=$(echo $line | cut -f 1,2 -d ' ' --complement)

		device=$(jq -n \
		    --arg name "$name" \
		    --arg address "$address" \
		    --arg paired "$paired" \
		    --arg connected "$connected" \
		    --arg battery "$battery" \
		    '{name: $name, address: $address, paired: $paired, connected: $connected, battery: $battery}')
		
		if [[ "$name" != "" ]]; then
			devices=$(echo $devices | jq --argjson x "$device" '. += [ $x ]')
		fi

	done	

	echo $devices | jq

}
