#!/usr/bin/env sh
## This is the script to setup thr FIFO and run the FIFO in a bar

BAR_FIFO=/tmp/bar-fifo-top
BAR_DIMEN=$(xrandr --properties | grep --perl-regexp --only-matching "(?<=primary ).*(?<=\+)\d+" | sed -E 's/x[0-9]{3,4}/x35/' | sed -E 's/\+[0-9]{3,4}$/\+0$/')
HOSTNAME=$(paste /etc/hostname)
#[ "$HOSTNAME" = "desk-beast" ] && BAR_FONT_0="Cascadia Code:size=18" || BAR_FONT_0="Cascadia Code:size=18"
[ "$HOSTNAME" = "desk-beast" ] && BAR_FONT_0="CaskaydiaCove Nerd Font Mono:size=20" || BAR_FONT_0="Cascadia Code:size=18"
[ "$HOSTNAME" = "desk-beast" ] && BAR_FONT_1="Cascadia Code:size=20" || BAR_FONT_1="CaskaydiaCove Nerd Font Mono:size=22"
BAR_WM_NAME=bspwm_bar_top
BAR_FG_COLOUR="#a7a5a5"
BAR_BG_COLOUR="#333232"

# Check if bar already running
if xdo id -a "$BAR_WM_NAME" > /dev/null ; then
    printf "%s\n" "The bar is already running." >&2
    exit 1
fi

# Each time trap is invoked, the action argument shall be processed in a manner equivalent to `eval action`
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# If an old FIFO exists, remove it and create a new one
[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"
mkfifo "$BAR_FIFO"

# Add blocks to bar
"$HOME/.local/bin/slstatus.datetime" -s > "$BAR_FIFO" &
"$HOME/git/scripts/shell/lemonbar_nextevent.sh" > "$BAR_FIFO" &
"$HOME/git/scripts/shell/corona" > "$BAR_FIFO" &
bspc subscribe report > "$BAR_FIFO" &

# Push the FIFO into the parsing script, then output that parsed to lemonbar
"$XDG_CONFIG_HOME/lemonbar/top_bar_script.sh" < "$BAR_FIFO" | lemonbar -a 32 -u 4 -n "$BAR_WM_NAME" -g "$BAR_DIMEN" -f "$BAR_FONT_0" -f "$BAR_FONT_1" -F "$BAR_FG_COLOUR" -B "$BAR_BG_COLOUR" | sh &

wid=$(xdo id -m -a "$BAR_WM_NAME")
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
