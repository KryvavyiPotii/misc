#!/bin/sh

# Simple script that shows system info.
# It is meant to be used by some status bar (especially sway-bar).
# Author: KryvavyiPotii


readonly ERR_INVALID_TEMP=4
readonly ERR_INVALID_ENERGY_NOW=5
readonly ERR_INVALID_ENERGY_FULL_DESIGN=6


is_num() {
    arg="$1"

    echo "$arg" | grep -Eq '^[0-9]+$'
}

get_temp() {
    temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)

    if ! is_num "$temp"; then
        echo "?"
        return $ERR_INVALID_TEMP
    fi

    echo "$(( $temp / 1000 ))°C"
}

get_power() {
    energy_now="$(cat /sys/class/power_supply/BAT0/energy_now)"
    
    if ! is_num "$energy_now"; then
        echo "?"
        return $ERR_INVALID_ENERGY_NOW
    fi
    
    energy_full_design="$(cat /sys/class/power_supply/BAT0/energy_full_design)"
    
    if ! is_num "$energy_full_design"; then
        echo "?"
        return $ERR_INVALID_ENERGY_FULL_DESIGN
    fi
    
    expression="$energy_now / $energy_full_design * 100"
    
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

    awk "BEGIN { printf(\"%d%%%c\", $expression, \"$charging_state\") }"
}

get_date() {
    date +"%H:%M %a %d %b %Y"
}


echo "$(get_temp) | $(get_power) | $(get_date)"
