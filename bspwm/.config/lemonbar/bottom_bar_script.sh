#!/usr/bin/env sh
## The script that parses the input from the init script

# Import colour variables
. $XDG_CONFIG_HOME/lemonbar/bar_colours

# Since this script takes in a named-pipe, can just read each line and parse it as it comes in
# We have set it up in the init script so that each line starts with a different letter so that we can case them
while read -r line; do
    case $line in
        # GPU
        G*)
            # Strip the 1st character
            line=${line#?}
            gpu=
            # Strip the percentage sign from the number
            line0=$(echo "$line" | awk '{print substr($2, 1, length($2)-1)}')
            if [ "$line0" -ge 75 ]; then
                gpu="[%{F$white}%{U$red}%{+u} ${line} %{-u}%{U-}%{F-}]"
            elif [ "$line0" -ge 50 ]; then
                gpu="[%{F$white}%{U$yellow}%{+u} ${line} %{-u}%{U-}%{F-}]"
            else
                gpu="[%{F$white}%{U$blue}%{+u} ${line} %{-u}%{U-}%{F-}]"
            fi
            ;;
        # CPU when using script
        C*)
            # Strip the 1st character and check the leader
            line=${line#?}
            line0=${line#?}
            case $line in
                U*)
                    cpu="[%{F$white}%{U$red}%{+u} ${line0} %{-u}%{U-}%{F-}]"
                    ;;
                H*)
                    cpu="[%{F$white}%{U$yellow}%{+u} ${line0} %{-u}%{U-}%{F-}]"
                    ;;
                L*)
                    cpu="[%{F$white}%{U$blue}%{+u} ${line0} %{-u}%{U-}%{F-}]"
                    ;;
            esac
            ;;
        # CPU when using slstatus
        #C*)
            ## Strip the 1st character and check the leader
            #line=${line#?}
            #cpu=
            ## Strip the percentage sign from the number
            #line0=${line%%%}
            #if [ "$line0" = "n/a" ]; then
                #cpu="[%{F$white}%{U$red}%{+u}  n/a %{-u}%{U-}%{F-}]"
            #elif [ "$line0" -ge 75 ]; then
                #cpu="[%{F$white}%{U$red}%{+u} ${line} %{-u}%{U-}%{F-}]"
            #elif [ "$line0" -ge 50 ]; then
                #cpu="[%{F$white}%{U$yellow}%{+u} ${line} %{-u}%{U-}%{F-}]"
            #else
                #cpu="[%{F$white}%{U$blue}%{+u} ${line} %{-u}%{U-}%{F-}]"
            #fi
            #;;
        # Memory
        M*)
            # Strip the 1st character and check the leader
            mem=
            line=${line#?}
            line0=${line%%%}
            if [ "$line0" -ge 75 ]; then
                mem="[%{F$white}%{U$red}%{+u}  ${line} %{-u}%{U-}%{F-}]"
            elif [ "$line0" -ge 50 ]; then
                mem="[%{F$white}%{U$yellow}%{+u}  ${line} %{-u}%{U-}%{F-}]"
            else
                mem="[%{F$white}%{U$blue}%{+u}  ${line} %{-u}%{U-}%{F-}]"
            fi
            ;;
        P*)
            # Packages
            pkg=
            line=${line#?}
            case $line in
                H*)
                    pkg="[%{F$white}%{U$red}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
                    ;;
                L*)
                    pkg="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
                    ;;
            esac
            ;;
        D*)
            #Timezones
            timezones="[%{F$white}%{U$grey}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
            ;;
        W*)
            #WLAN rate
            wlan="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
            ;;
        R*)
            #Weather
            weather="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
            ;;
        B*)
            ##Battery
            bat=${line#?}
            ;;
        F*)
            ##Fuelwatch
            fuel="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
            ;;
        A*)
            ## Mullvad
            connected="${line#?}"
            case $connected in
                "YES") vpn="[%{F$white}%{U$blue}%{+u}  %{-u}%{U-}%{F-}]" ;;
                *) vpn="[%{F$white}%{U$red}%{+u}  %{-u}%{U-}%{F-}]" ;;
            esac
            ;;
        V*)
            ##Volume
            vol=
            line=${line#?}
            case $line in
                m*)
                    #Muted
                    vol="[%{F$white}%{U$grey}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
                    ;;
                L*)
                    #Low
                    vol="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
                    ;;
                M*)
                    #Med
                    vol="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
                    ;;
                H*)
                    #High
                    vol="[%{F$white}%{U$blue}%{+u} ${line#?} %{-u}%{U-}%{F-}]"
                    ;;
            esac
            ;;
    esac
    printf "%s\n" "%{S1}%{l}%{c}${weather}${fuel}${pkg}${cpu}${gpu}${mem}${bat}${vol}${vpn}${wlan}${timezones}%{r}"
done
