#!/usr/bin/zsh
### Creates a FIFO for recording updates so it refreshes when i manually update

BAR_FIFO='/tmp/waybar-updates'

# If an old FIFO exists, remove it and create a new one
[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"
mkfifo "$BAR_FIFO"

# Kill any running waybar-update process
killall -9 waybar-updates

# Send info to the FIFO
waybar-updates --format '{aur}  {pacman}' --interval 3600 2> /dev/null > /tmp/waybar-updates &

# Output the FIFO
while read -r line; do
    printf "%s\n" "$line"
done < /tmp/waybar-updates
