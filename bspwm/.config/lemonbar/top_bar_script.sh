#!/usr/bin/env sh
## The script that parses the input from the init script

# Import colour variables
. $XDG_CONFIG_HOME/lemonbar/bar_colours

num_mon=$(bspc query -M | wc -l)

# Since this script takes in a named-pipe, can just read each line and parse it as it comes in
# We have set it up in the init script so that each line starts with a different letter so that we can case them
while read -r line; do
    case $line in
        # I have set the time script to always start with a T
        T*)
            # Strip the 1st character
            time="%{F$white}%{U$grey} %{+u}${line#?}%{-u} %{U-}%{F-}"
            ;;
        # Next event starts with a N
        N*)
            nextevent="%{F$white}%{U$grey} %{+u}${line#?}%{-u} %{U-}%{F-}"
            ;;
        # bspc subcribe report output always starts with a W
        W*)
            wm=
            # Internal field seperator is :
            IFS=':'
            set -- ${line#?}
            while [ $# -gt 0 ] ; do
                item=$1
                name=${item#?}
                # Each item in the report has a letter and a number
                case $item in
                    # Monitors
                    [mM]*)
                        case $item in
                            # Unfocussed Monitor
                            m*)
                                FG=$grey
                                on_focused_monitor=
                                ;;
                            #Focussed monitor
                            M*)
                                FG=$blue
                                on_focused_monitor=1
                                ;;
                        esac
                        [ "$num_mon" -lt 2 ] && shift && continue
                        wm="${wm}%{F${FG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{F-}"
                        ;;
                    # Desktops
                    [fFoOuU]*)
                        case $item in
                            # Free Desktop
                            f*)
                                FG=$black
                                UL=$FG
                                ;;
                            # Focussed
                            F*)
                                # Focussed but free
                                if [ "$on_focused_monitor" ] ; then
                                    FG=$white
                                    UL=$blue
                                # Active but free
                                else
                                    FG=$red
                                    UL=$FG
                                fi
                                ;;
                            # Occupied Desktop
                            o*)
                                FG=$grey
                                UL=$grey
                                ;;
                            # Occupied
                            O*)
                                # Focussed and occupied
                                if [ "$on_focused_monitor" ] ; then
                                    FG=$white
                                    UL=$blue
                                # Active and ocupied
                                else
                                    FG=$bright_green
                                    UL=$FG
                                fi
                                ;;
                            # Urgent
                            u*)
                                FG=$bright_red
                                UL=$FG
                                ;;
                            U*)
                                # Focussed urgent
                                if [ "$on_focused_monitor" ] ; then
                                    FG=$bright_white
                                    UL=$FG
                                # Active urgent
                                else
                                    FG=$red
                                    UL=$FG
                                fi
                                ;;
                        esac
                        wm="${wm}%{F${FG}}%{U${UL}}%{+u}%{A:bspc desktop -f ${name}:} ${name} %{A}%{F-}%{-u}"
                        ;;
                    # Layout, state, flags
                    [LTG]*)
                        #wm="${wm}%{F$COLOR_STATE_FG}%{B$COLOR_STATE_BG} ${name} %{B-}%{F-}"
                        ;;
                esac
                shift
            done
            ;;
    esac
    printf "%s\n" "%{l}${wm}%{r}${nextevent} | ${time}"
done
