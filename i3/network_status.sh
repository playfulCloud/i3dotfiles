#!/bin/bash



# Sprawdzamy, czy istnieje aktywne połączenie Ethernet
ethernet_interface=$(ip link show | grep 'state UP' | grep -o '^[0-9]: [^:]*' | grep -E 'eth|en' | cut -d: -f2 | tr -d ' ')
# Sprawdzamy, czy istnieje aktywne połączenie WiFi
wifi_interface=$(ip link show | grep 'state UP' | grep -o '^[0-9]: [^:]*' | grep -E 'wlan|wifi' | cut -d: -f2 | tr -d ' ')

if [ -n "$ethernet_interface" ]; then
    quality="stable"
elif [ -n "$wifi_interface" ]; then
    # Pobieramy siłę sygnału WiFi
    signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*' | cut -d: -f2)
    if [ -z "$signal" ]; then
        quality="disconnected (WiFi)"
    elif [ "$signal" -ge 75 ]; then
        quality="stable (WiFi)"
    elif [ "$signal" -ge 40 ]; then
        quality="low (WiFi)"
    else
        quality="disconnected (WiFi)"
    fi
else
    quality="disconnected"
fi

echo $quality

