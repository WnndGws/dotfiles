#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

if [ "$HOST" = "arch-t470s" ]; then
    SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_laptop_netspeed
else
    SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_beast_netspeed
fi

"$SLSFILE" -s\
    | jq --unbuffered --compact-output -R 'split("+") | {text: (.[0] + " " + .[1]), class: (if ((.[0] | split(" ") | .[-1]) != "bi" and (.[0] | split(" ") | .[-1]) != "Ki") or ((.[1] | split(" ") | .[-1]) != "bi" and (.[1] | split(" ") | .[-1]) != "Ki") then "red" else "green" end)}'
