#!/usr/bin/zsh
## Change laptop brightness to match battery percentage

while true; do
    BAT="$("$XDG_CONFIG_HOME"/waybar/slstatus_battery_perc -1)"

    # Replace a leading o with a leading +
    BAT="${BAT/o/+}"

    # Set to 100 if charging (denoted by +ve) or to percentage (denoted by -ve)
    [[ $BAT -gt 0 ]] && BAT=100 || BAT=${BAT:1}

    brightnessctl set "$BAT"%

    sleep 500
done
