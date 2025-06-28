#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_cpu_temps

"$SLSFILE" -s | jq --unbuffered --compact-output -R '
 . as $raw |
 ($raw|split("+")|map(tonumber)|add/length) as $avg |
 {text: "\($avg|round)degC",
 class: (if $avg <40 then "green"
 elif $avg <65 then "orange"
 else "red" end),
 alt: "\($raw)",
 percentage: $avg}
'
