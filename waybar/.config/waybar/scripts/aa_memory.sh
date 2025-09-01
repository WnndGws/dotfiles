#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_memory

"$SLSFILE" -s | jq --unbuffered --compact-output -R '
 . as $raw |
 ($raw|split("+")) as $nums |
 {text: "\($nums[0])",
 class: (if $nums[-1]|tonumber <40 then "green"
 elif $nums[-1]|tonumber <65 then "orange"
 else "red" end),
 percentage: $nums[-1]|tonumber}
'
