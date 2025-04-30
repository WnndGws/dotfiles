#!/usr/bin/zsh
## Check next event once an hour

printf '{"text": "Checking calendar"}' | jq --unbuffered --compact-output .

"$HOME/git/scripts/next_event/.venv/bin/python3" "$HOME/git/scripts/next_event/next_event.py" | jq --unbuffered --compact-output -R 'split("\n") | {text: .[0]}'
