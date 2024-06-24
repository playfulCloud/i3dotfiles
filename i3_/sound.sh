#!/bin/bash

# Pobierz poziom głośności
VOLUME=$(amixer get Master | awk -F'[][]' 'END{ print $2 }' | sed 's/%//')
MUTE=$(amixer get Master | awk -F'[][]' '/\[off\]/ { print $4 }')

# Ustal odpowiednią ikonę w zależności od poziomu głośności
if [ "$MUTE" == "off" ]; then
    ICON=" "  # Ikona wyciszenia
elif [ "$VOLUME" -eq 0 ]; then
    ICON=""  # Ikona najniższego poziomu głośności
elif [ "$VOLUME" -lt 50 ]; then
    ICON=""  # Ikona średniego poziomu głośności
else
    ICON=" "  # Ikona najwyższego poziomu głośności
fi

echo "$ICON $VOLUME%"

