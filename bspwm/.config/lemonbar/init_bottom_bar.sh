#!/usr/bin/env sh
## This is the script to setup thr FIFO and run the FIFO in a bar

BAR_FIFO=/tmp/bar-fifo-bottom
BAR_HEIGHT=35
BAR_FONT="CaskaydiaCove Nerd Font Mono:size=20"
BAR_WM_NAME=bspwm_bar_bottom
BAR_FG_COLOUR="#a7a5a5"
BAR_BG_COLOUR="#333232"

# Check if bar already running
if xdo id -a "$BAR_WM_NAME" > /dev/null ; then
    printf "%s\n" "The bar is already running." >&2
    exit 1
fi

# Each time trap is invoked, the action argument shall be processed in a manner equivalent to `eval action`
# When this script quits, exit the bar
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# If an old FIFO exists, remove it and create a new one
[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"
mkfifo "$BAR_FIFO"

# Order: weather, pkg, mem, cpu, vol, wlan_speed, wlan_dl
# TODO: weather, vol, wlan_speed, wlan_dl
# Add blocks to bar
"$HOME/git/scripts/shell/lemonbar_pkg" > "$BAR_FIFO" &
"$HOME/git/scripts/shell/lemonbar_cpu" > "$BAR_FIFO" &
"$HOME/git/scripts/shell/lemonbar_mem" > "$BAR_FIFO" &
"$HOME/git/scripts/shell/lemonbar_wlanrate" > "$BAR_FIFO" &
"$HOME/git/scripts/shell/lemonbar_battery.sh" > "$BAR_FIFO" &

# Push the FIFO into the parsing script, then output that parsed to lemonbar
"$XDG_CONFIG_HOME/lemonbar/bottom_bar_script.sh" < "$BAR_FIFO" | lemonbar -b -a 32 -u 3 -n "$BAR_WM_NAME" -g x$BAR_HEIGHT -f "$BAR_FONT" -F "$BAR_FG_COLOUR" -B "$BAR_BG_COLOUR" | sh &

wid=$(xdo id -m -a "$BAR_WM_NAME")
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
