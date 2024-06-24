#!/bin/bash
#!/bin/bash

# Funkcja do sprawdzenia, czy połączenie jest przez Ethernet
check_ethernet() {
    ip link show eth0 | grep 'state UP' > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "wired"
        exit 0
    fi
}

# Funkcja do sprawdzenia, czy połączenie jest przez Wi-Fi i zwrócenia mocy sygnału
check_wifi() {
    wifi_interface=$(iw dev | awk '$1=="Interface"{print $2}')
    if [ -n "$wifi_interface" ]; then
        signal=$(iwconfig $wifi_interface | grep 'Link Quality' | awk '{print $2}' | cut -d'=' -f2)
        if [ -n "$signal" ]; then
            echo "Wi-Fi signal strength: $signal"
            exit 0
        fi
    fi
}

# Sprawdzanie stanu połączenia
connection_state=$(nmcli -t -f STATE general)
if [ "$connection_state" = "connecting" ]; then
    echo "connecting"
    exit 0
fi

# Sprawdzanie, czy połączenie jest przez Ethernet
check_ethernet

# Sprawdzanie, czy połączenie jest przez Wi-Fi
check_wifi

# Jeśli nie znaleziono żadnego połączenia
echo "No network connection"
exit 1

