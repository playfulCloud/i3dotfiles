#!/bin/bash

# Get battery status and percentage
battery_info=$(acpi -b)
battery_percentage=$(echo $battery_info | grep -P -o '[0-9]+(?=%)')
charging_status=$(echo $battery_info | grep -o 'Charging\|Discharging\|Full')

# Determine the icon based on battery percentage and charging status
if [ "$charging_status" = "Charging" ]; then
    if [ "$battery_percentage" -ge 80 ]; then
        icon=""  # Charging and almost full
    elif [ "$battery_percentage" -ge 60 ]; then
        icon=""  # Charging and 3/4 full
    elif [ "$battery_percentage" -ge 40 ]; then
        icon=""  # Charging and half full
    elif [ "$battery_percentage" -ge 20 ]; then
        icon=""  # Charging and 1/4 full
    else
        icon=""  # Charging and almost empty
    fi
elif [ "$charging_status" = "Discharging" ]; then
    if [ "$battery_percentage" -ge 80 ]; then
        icon=""  # Full battery
    elif [ "$battery_percentage" -ge 60 ]; then
        icon=""  # 3/4 battery
    elif [ "$battery_percentage" -ge 40 ]; then
        icon=""  # Half battery
    elif [ "$battery_percentage" -ge 20 ]; then
        icon=""  # 1/4 battery
    else
        icon=""  # Empty battery
    fi
else
    icon=""  # Full or Unknown state
fi

# Display the icon and battery percentage
echo "$icon $battery_percentage%"

