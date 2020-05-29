#!/usr/bin/env sh
## The script that parses the input from the init script

# Import colour variables
. $XDG_CONFIG_HOME/lemonbar/bar_colours

num_mon=$(bspc query -M | wc -l)

# Since this script takes in a named-pipe, can just read each line and parse it as it comes in
# We have set it up in the init script so that each line starts with a different letter so that we can case them
while read -r line; do
    case $line in
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
                                FG=$COLOR_MONITOR_FG
                                BG=$COLOR_MONITOR_BG
                                on_focused_monitor=
                                ;;
                            #Focussed monitor
                            M*)
                                FG=$COLOR_FOCUSED_MONITOR_FG
                                BG=$COLOR_FOCUSED_MONITOR_BG
                                on_focused_monitor=1
                                ;;
                        esac
                        [ $num_mon -lt 2 ] && shift && continue
                        wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
                        ;;
                    # Desktops
                    [fFoOuU]*)
                        case $item in
                            # Free Desktop
                            f*)
                                FG=$COLOR_FREE_FG
                                BG=$COLOR_FREE_BG
                                UL=$BG
                                ;;
                            # Focussed
                            F*)
                                # Focussed but free
                                if [ "$on_focused_monitor" ] ; then
                                    FG=$COLOR_FOCUSED_FREE_FG
                                    BG=$COLOR_FOCUSED_FREE_BG
                                    UL=$BG
                                # Active but free
                                else
                                    FG=$COLOR_FREE_FG
                                    BG=$COLOR_FREE_BG
                                    UL=$COLOR_FOCUSED_FREE_BG
                                fi
                                ;;
                            # Occupied Desktop
                            o*)
                                FG=$COLOR_OCCUPIED_FG
                                BG=$COLOR_OCCUPIED_BG
                                UL=$BG
                                ;;
                            # Occupied
                            O*)
                                # Focussed and occupied
                                if [ "$on_focused_monitor" ] ; then
                                    FG=$COLOR_FOCUSED_OCCUPIED_FG
                                    BG=$COLOR_FOCUSED_OCCUPIED_BG
                                    UL=$BG
                                # Active and ocupied
                                else
                                    FG=$COLOR_OCCUPIED_FG
                                    BG=$COLOR_OCCUPIED_BG
                                    UL=$COLOR_FOCUSED_OCCUPIED_BG
                                fi
                                ;;
                            # Urgent
                            u*)
                                FG=$COLOR_URGENT_FG
                                BG=$COLOR_URGENT_BG
                                UL=$BG
                                ;;
                            U*)
                                # Focussed urgent
                                if [ "$on_focused_monitor" ] ; then
                                    FG=$COLOR_FOCUSED_URGENT_FG
                                    BG=$COLOR_FOCUSED_URGENT_BG
                                    UL=$BG
                                # Active urgent
                                else
                                    FG=$COLOR_URGENT_FG
                                    BG=$COLOR_URGENT_BG
                                    UL=$COLOR_FOCUSED_URGENT_BG
                                fi
                                ;;
                        esac
                        wm="${wm}%{F${FG}}%{B${BG}}%{U${UL}}%{+u}%{A:bspc desktop -f ${name}:} ${name} %{A}%{B-}%{F-}%{-u}"
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
    printf "%s\n" "%{l}${wm}%{c}${title}%{r}${sys}"
done


