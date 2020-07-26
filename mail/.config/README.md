# Mail setup
My setup uses 3 utilities:
* isync-config-patched
    * Uses XDG compliant dirs
* neomutt
* notmuch

## How this works for me

0. Run `mbsync -a` to get the gmail folder [All Mail]
0. Run notmuch_hook.sh
    0. This labels all new mail as 'new' and 'inbox' then removes those tags based on rules
0. View with neomutt
