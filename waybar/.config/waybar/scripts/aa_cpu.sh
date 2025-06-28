#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_cpu

"$SLSFILE" -s | jq --unbuffered --compact-output -R '. as $raw | ($raw|gsub("[^0-9.]";"")|tonumber) as $num | {text: " \($raw)%", class: (if $num <50 then "green" elif $num <75 then "orange" else "red" end), percentage: $num}'
