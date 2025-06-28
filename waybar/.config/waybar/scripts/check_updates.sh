#!/usr/bin/zsh
### Creates a FIFO for recording updates so it refreshes when i manually update

# Cleanup on exit (in BASH its not INT, its EXIT)
trap 'kill $(pidof -x "$0")' INT

# Check if another instance of this script is running
pidof -o %PPID -x "$0" >/dev/null && echo "ERROR: Script $0 already running" && exit 1

# If an old FIFO exists, remove it and create a new one
BAR_FIFO='/tmp/waybar-updates'
[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"

# Create a named pipe, deletes pipe (but will keept it intact until the script ends
mkfifo "$BAR_FIFO"
exec 3<> "$BAR_FIFO"

printf '{"text": "Checking updates..."}' | jq --unbuffered --compact-output .
# Send info to the FIFO
while true; do
    PACMAN_CHECK=$(checkupdates | wc -l || echo "0")
    AUR_CHECK=$(checkupdates-with-aur| wc -l || echo "0")

    (( AUR_FINAL = AUR_CHECK - PACMAN_CHECK ))
    (( PACMAN_FINAL = PACMAN_CHECK - AUR_FINAL ))

    printf "$PACMAN_FINAL  $AUR_FINAL\n" | jq --unbuffered --compact-output -R 'split("\n") | {text: .[0]}'

    #PAC_KERNAL=$(file /boot/vmlinuz-linux | rg --pcre2 --only-matching "(?<=version ).*? ")
    #RUNNING_KERNAL=$(uname -r)

    #[ $PAC_KERNAL = $RUNNING_KERNAL ]

    sleep 3600
done &

# Output the FIFO
while read -r line; do
    printf "%s\n" "$line"
done < "$BAR_FIFO"
