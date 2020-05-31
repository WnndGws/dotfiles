#!/usr/bin/env sh
## The script that parses the input from the init script

# Import colour variables
. $XDG_CONFIG_HOME/lemonbar/bar_colours

# Since this script takes in a named-pipe, can just read each line and parse it as it comes in
# We have set it up in the init script so that each line starts with a different letter so that we can case them
while read -r line; do
    case $line in
        # CPU
        C*)
            # Strip the 1st character and check the leader
            cpu=
            line=${line#?}
            case $line in
                U*)
                    cpu="%{F$white%{U$red} %{+u}${line#?}%{-u} %{U-}%{F-}"
                    ;;
                H*)
                    cpu="%{F$white%{U$yellow} %{+u}${line#?}%{-u} %{U-}%{F-}"
                    ;;
                L*)
                    cpu="%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}"
                    ;;
            esac
            ;;
        # Memory
        M*)
            # Strip the 1st character and check the leader
            mem=
            line=${line#?}
            case $line in
                U*)
                    mem="%{F$white%{U$red} %{+u}${line#?}%{-u} %{U-}%{F-}"
                    ;;
                H*)
                    mem="%{F$white%{U$yellow} %{+u}${line#?}%{-u} %{U-}%{F-}"
                    ;;
                M*)
                    mem="%{F$white}%{U$yellow} %{+u}${line#?}%{-u} %{U-}%{F-}"
                    ;;
                L*)
                    mem="%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}"
            esac
            ;;
    esac
    printf "%s\n" "%{l}%{c}${cpu}|${mem}%{r}"
done
