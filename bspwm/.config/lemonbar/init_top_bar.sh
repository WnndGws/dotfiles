#!/usr/bin/env sh
## This is the script to setup thr FIFO and run the FIFO in a bar

PANEL_FIFO=/tmp/panel-fifo-top
PANEL_HEIGHT=24
PANEL_FONT="-*-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
PANEL_WM_NAME=bspwm_panel_top

# Check if panel already running
if xdo id -a "$PANEL_WM_NAME" > /dev/null ; then
    printf "%s\n" "The panel is already running." >&2
    exit 1
fi

# Each time trap is invoked, the action argument shall be processed in a manner equivalent to `eval action`
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# If an old FIFO exists, remove it and create a new one
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

# Add blocks to panel
bspc subscribe report > "$PANEL_FIFO" &

# Import colours
. ./bar_colours

# Push the FIFO into the parsing script, then output that parsed to lemonbar
./top_bar_script.sh < "$PANEL_FIFO" | lemonbar -a 32 -u 2 -n "$PANEL_WM_NAME" -g x$PANEL_HEIGHT -f "$PANEL_FONT" -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" | sh &

wid=$(xdo id -m -a "$PANEL_WM_NAME")
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
