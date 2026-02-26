#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

# check the route, find the 2nd last column in 1st row, then exit
ROUTE="$(ip route | awk '{print $(NF-2);exit}')"

# test for ethernet, since wi-fi script will return disconnected as a fail, which i want
if [[ $ROUTE == "enp0s31f6" ]]; then
    # print last column of last line
    IP="$(ip route | awk 'END{print $(NF)}')"
    printf "$IP+100" | jq --unbuffered --compact-output -R '
    . as $raw |
    ($raw|split("+")) as $nums |
    {text: (if $nums[-1]|tonumber <1 then "Disconnected"
    else "\($nums[0])" end),
    class: (if $nums[-1]|tonumber <1 then "red"
    elif $nums[-1]|tonumber <50 then "yellow"
    else "green" end),
    alt: (if $nums[-1]|tonumber <1 then "disconnected"
    else "ethernet" end),
    percentage: $nums[-1]|tonumber}
    '

else;
    SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_wifi

    "$SLSFILE" -s | jq --unbuffered --compact-output -R '
    . as $raw |
    ($raw|split("+")) as $nums |
    {text: (if $nums[-1]|tonumber <1 then "Disconnected"
    else "\($nums[0])" end),
    class: (if $nums[-1]|tonumber <1 then "red"
    elif $nums[-1]|tonumber <50 then "yellow"
    else "green" end),
    alt: (if $nums[-1]|tonumber <1 then "disconnected"
    else "connected" end),
    percentage: $nums[-1]|tonumber}
    '
fi
