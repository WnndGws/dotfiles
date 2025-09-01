#!/usr/bin/zsh
## Convert slstatrus to json using awk

# Ive created an slstatus that splits the outputs with a + symbol
# Then i split the up and down by spaces to get the units of each
# Units are then converted into a class to use for styling

mullvad status --json listen | jq --unbuffered --compact-output '.text = .state | .class = .state | .alt = .state'
