#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

SLSFILE="$XDG_CONFIG_HOME"/waybar/scripts/slstatus_cpu_temps

# percentage is used to choose an icon, so 65 needs to be 25%, 75 needs to be 50% etc

"$SLSFILE" -s | jq --unbuffered --compact-output -R '
def pct($avg):
  if   $avg <= 40 then 25
  elif $avg <= 65 then 25 + ($avg - 40)
  elif $avg <= 75 then 50 + ($avg - 65) * 2.5
  else 75 + ($avg - 75) * 2.5 end;
 . as $raw |
 ($raw|split("+")|map(tonumber)|add/length) as $avg |
 {text: "\($avg|round)°C",
 class: (if $avg <40 then "green"
 elif $avg <65 then "yellow"
 elif $avg <75 then "orange"
 else "red" end),
 alt: "\($raw)",
 percentage: $avg}
'
