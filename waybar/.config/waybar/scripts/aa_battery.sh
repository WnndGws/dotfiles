#!/usr/bin/zsh
## Convert slstatrus to json using awk

## MAYBE SWAP TO PYTHON SO CAN USE WATCHDOG?

SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_battery

"$SLSFILE" -s | jq --unbuffered --compact-output -R '
split("x")
| [.[] | split("_")
  | {
      percentage: .[0],
      time: (if .[1] != "" then .[1] else "Full" end),
      suffix: .[2]
    }]
| {
    text: "\(.[0].percentage)% (\(.[0].time)) | \(.[1].percentage)% (\(.[1].time))",
    class: (
      if (.[0].suffix == "+" or .[1].suffix == "+") then "charging"
      elif (.[0].suffix == "o" and .[1].suffix == "o") then "full"
      elif (.[0].suffix == "-" or .[1].suffix == "-") then "discharging"
      else "unknown"
      end
    ),
    percentage: ((
      (.[0].percentage | tonumber) + (.[1].percentage | tonumber)
    ) / 2)
  } | . + {alt: .class}
'
