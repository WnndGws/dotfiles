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

"$SLSFILE" -s | jq --unbuffered --compact-output -R '
  split("x")
  | [.[] | split(" ")
    | {
        # If the entry after splitting doesnt have units, then remove trailing 0
        speed: (if .[1] != "" then .[0] else .[0] | split(".0")[0] end)
            # Then, if the number isnt 4 characters long, add spaces to the front until it is
            | (if (. | length) < 4 then (" " * ( 4 - (. |length))) + . else . end),
        unit: (if .[1] != "" then .[1] else "bi" end)
    }]
| {
    text: " \(.[0].speed) \(.[0].unit)   \(.[1].speed) \(.[1].unit)",
    class: (
        ["bi", "Ki", "Mi", "Gi", "Ti"] as $order |
        map(.unit as $u | $order | index($u)) | max as $max_rank |
        $order[$max_rank]
    )
  }
'
