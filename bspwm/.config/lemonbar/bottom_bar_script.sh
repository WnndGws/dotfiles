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
            line=${line#?}
            cpu=
            # Strip the percentage sign from the number
            line0=${line%%%}
            if [ $line0 -ge 75 ]; then
                cpu="[%{F$white}%{U$red} %{+u} ${line}%{-u} %{U-}%{F-}]"
            elif [ $line0 -ge 50 ]; then
                cpu="[%{F$white}%{U$yellow} %{+u} ${line}%{-u} %{U-}%{F-}]"
            else
                cpu="[%{F$white}%{U$blue} %{+u} ${line}%{-u} %{U-}%{F-}]"
            fi
            ;;
        # Memory
        M*)
            # Strip the 1st character and check the leader
            mem=
            line=${line#?}
            case $line in
                U*)
                    mem="[%{F$white}%{U$red} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                H*)
                    mem="[%{F$white}%{U$yellow} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                M*)
                    mem="[%{F$white}%{U$yellow} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                L*)
                    mem="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
            esac
            ;;
        P*)
            # Packages
            pkg=
            line=${line#?}
            case $line in
                H*)
                    pkg="[%{F$white}%{U$red} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                L*)
                    pkg="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
            esac
            ;;
        W*)
            #WLAN rate
            wlan="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
            ;;
        R*)
            #Weather
            weather="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
            ;;
        B*)
            ##Battery
            bat=${line#?}
            ;;
        V*)
            ##Volume
            vol=
            line=${line#?}
            case $line in
                m*)
                    #Muted
                    vol="[%{F$white}%{U$grey} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                L*)
                    #Low
                    vol="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                M*)
                    #Med
                    vol="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
                H*)
                    #High
                    vol="[%{F$white}%{U$blue} %{+u}${line#?}%{-u} %{U-}%{F-}]"
                    ;;
            esac
            ;;
    esac
    printf "%s\n" "%{l}%{c}${weather}${pkg}${cpu}${mem}${bat}${vol}${wlan}%{r}"
done
