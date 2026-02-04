#!/bin/sh

# Simple script that shows system info.
# It is meant to be used by some status bar.


get_temp() {
    temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)

    echo "$(( $temp / 1000 ))°C"
}

get_power() {
    energy_now="$(cat /sys/class/power_supply/BAT0/energy_now)"
    energy_full_design="$(cat /sys/class/power_supply/BAT0/energy_full_design)"
    expression="$energy_now / $energy_full_design * 100"
    
    energy_percentage=$(awk "BEGIN { printf(\"%d\", $expression) }")

    case "$(cat /sys/class/power_supply/BAT0/status)" in
        Discharging) 
            charging_state="-" 
            ;;
        Charging)
            charging_state="+" 
            ;;
        *)
            charging_state="?"
            ;;
    esac

    echo "${energy_percentage}%${charging_state}"
}

get_date() {
    date +"%H:%M %a %d %b %Y"
}


echo "$(get_temp) | $(get_power) | $(get_date)"
