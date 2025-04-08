#!/usr/bin/zsh
### Creates a FIFO for recording updates so it refreshes when i manually update

BAR_FIFO='/tmp/waybar-updates'

# If an old FIFO exists, remove it and create a new one
[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"
mkfifo "$BAR_FIFO"

# Kill any running waybar-update process
killall -9 waybar-updates

# Send info to the FIFO
while true; do
    waybar-updates --format '{aur}   {pacman}' --once > /tmp/waybar-updates

    #PAC_KERNAL=$(file /boot/vmlinuz-linux | rg --pcre2 --only-matching "(?<=version ).*? ")
    #RUNNING_KERNAL=$(uname -r)

    #[ $PAC_KERNAL = $RUNNING_KERNAL ]

    sleep 3600
done &

# Output the FIFO
while read -r line; do
    printf "%s\n" "$line"
done < "$BAR_FIFO"
