#!/usr/bin/zsh
### Creates a FIFO for recording updates so it refreshes when i manually update

# https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
snore() {
    if [[ -n $1 ]]; then
        ( zselect -t $(( $1*100 )) ) &>/dev/null || return 0
    fi
    return 1
}

TIMEOUT=60

while snore "$TIMEOUT"; do
    PACMAN_CHECK=$(checkupdates | wc -l || echo "0")
    AUR_CHECK=$(aur-check-updates --raw | wc -l || echo "0")
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

    sleep 600
done
