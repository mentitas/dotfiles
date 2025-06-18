#!/usr/bin/env bash

nmcli -t d wifi rescan
LIST=$(nmcli --fields SSID,SECURITY,BARS device wifi list | sed '/^--/d' | sed 1d | sed -E "s/WPA*.?\S/~~/g" | sed "s/~~ ~~/~~/g;s/802\.1X//g;s/--/~~/g;s/  *~/~/g;s/~  */~/g;s/_/ /g" | column -t -s '~')

# get current connection status
CONSTATE=$(nmcli -fields WIFI g)
if [[ "$CONSTATE" =~ "enabled" ]]; then
    TOGGLE="Disable WiFi"
elif [[ "$CONSTATE" =~ "disabled" ]]; then
    TOGGLE="Enable WiFi"
fi

if [ -z "$1" ]; then
    echo -e "$TOGGLE\n$LIST"
else
    CHENTRY=$1
    CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')
    notify-send "$CHSSID"
    
    if [ "$CHENTRY" = "" ]; then
        exit
    elif [ "$CHENTRY" = "Enable WiFi" ]; then
        nmcli radio wifi on
    elif [ "$CHENTRY" = "Disable WiFi" ]; then
        nmcli radio wifi off
    else
        # get list of known connections
        KNOWNCON=$(nmcli connection show)
        
        # If the connection is already in use, then this will still be able to get the SSID
        if [ "$CHSSID" = "*" ]; then
            CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
        fi
    
        # Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
        if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
            nmcli con up "$CHSSID"
        else
            if [[ "$CHENTRY" =~ "" ]]; then
                WIFIPASS=$(echo " Press Enter if network is saved" | rofi -dmenu -p " WiFi Password: " -lines 1 ) # FIX! no puedo llamar a rofi dentro de rofi
            fi
            if nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
            then
                notify-send 'Connection successful'
            else
                notify-send 'Connection failed'
            fi
        fi
    fi

fi


