#!/bin/sh
#
# Check the system status

get_battery() {
    read bat_perc < /sys/class/power_supply/BAT1/capacity
    read bat_status < /sys/class/power_supply/BAT1/status
    # Send warning if battery is low and no charger is plugged in
    test "${bat_perc}" -le 5 && test "${bat_status}" != 'Charging' \
        && notify-send --urgency=ciritcal "Plug in a charger, low battery!"
    printf "${bat_perc}-${bat_status}"
}

main() {
    while true; do
      get_battery
      sleep 60
    done
}

main

