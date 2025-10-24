#!/usr/bin/zsh
### Creates a FIFO for recording updates so it refreshes when i manually update

# # Set variables
# FIFO_NAME="updates"
# SCRIPT_SLEEP_SECONDS=3600
#
# # Check no FIFO exists, and create one
# check_and_refresh_fifo() {
# local fifo_path=/tmp/fifo_"$FIFO_NAME"
# local now=$(date +%s)
# # Add 10s to the stated limit to avoid deleting creating loop
# local age_limit=$(("$1" + 10))

# if [[ -p $fifo_path ]]; then
# local mtime=$(stat -c %Y -- "$fifo_path" 2>/dev/null || stat -f %m -- "$fifo_path" 2>/dev/null)
# local age=$((now - mtime))
# (( age > age_limit )) && rm -f -- "$fifo_path"
# fi

# [[ ! -p $fifo_path ]] && mkfifo -- "$fifo_path"
# }

# Used to have a while loop, loop with waybar instead now
# check_and_refresh_fifo "$SCRIPT_SLEEP_SECONDS"

echo '{"text":" Refreshing...", "class":"green"}' | jq --compact-output .

PACMAN_CHECK=$(checkupdates | wc -l || echo "0") && AUR_CHECK=$(sleep 5 && aur-check-updates --raw | wc -l || echo "0")
(( TOTAL = AUR_CHECK + PACMAN_CHECK ))

CURRENT_KERNAL=$(pacman -Qi linux | sed -n 's/^Version\s*:\s*\([0-9.]*\).*/\1/p')
CURRENT_KERNAL=${CURRENT_KERNAL:0:-1}
RUNNING_KERNAL=$(uname -r | sed 's/-arch.*//')

if [[ "$TOTAL" -gt 0 ]]; then
    CLASS="yellow"
else
    CLASS="green"
fi

if [[ "$CURRENT_KERNAL" == "$RUNNING_KERNAL" ]]; then
    ICON="󰸞"
else
    ICON="󱈸" && CLASS="red"
fi

(( AUR_FINAL = AUR_CHECK ))
(( PACMAN_FINAL = PACMAN_CHECK ))

printf "$PACMAN_FINAL $ICON $AUR_FINAL\n" | jq --unbuffered --compact-output -R --arg class "$CLASS" 'split("\n") | {text: .[0], class: $class}'
