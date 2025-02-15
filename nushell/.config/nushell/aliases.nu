#. ------------------ #
# >>>>> ALIASES <<<<< #
#. ------------------ #

#. ------------------ #
# >>>>> Updates <<<<< #
#. ------------------ #
def archdate [] { pikaur --sync --refresh --sysupgrade --rebuild --needed ; pikaur --deptest ; tldr --update ; checkrebuild }
alias ad = archdate
alias paorph = pacman --query --unrequired --deps --quiet
alias po = paorph
def porm [] { pacman --query --unrequired --deps --quiet | xargs -I() pikaur -R --noconfirm (); pacman --query --unrequired --deps --quiet | xargs -I() pikaur -R --noconfirm (); pacman --query --unrequired --deps --quiet | xargs -I() pikaur -R --noconfirm () }
def p [package] { ~/git/fzf-scripts/pkgsearch ($package) }
alias pare = ~/git/fzf-scripts/pkgrm -s
alias pin = pikaur -S --noconfirm
alias pir = pikaur -S --rebuild

#. --------------- #
# >>>>> Lazy <<<<< #
#. --------------- #
alias nv = nvim
alias sv = sudo nvim
alias md = mkdir -v
alias cx = chmod +x

alias hl = hyprland

#List all including hidden
alias ll = ls -la
alias lt = eza --color always --color-scale all --tree --level=5
alias lta = eza --all --color always --color-scale all --tree --level=5

#Uses myman script
alias mm = wyman

#tmux in one command
def tm [name] { try {tmux attach -t ($name)} catch {tmux new -s ($name)} }

#Shortcut for pipenv
alias pes = pipenv shell
alias pipenv_defaults = pipenv install addict alive-progress arrow decorator httpx plumbum questionary tenacity ujson anybadge click configparser humanize loguru pathlib regex rich schedule thefuzz

#I always use rsync with these flags
alias rs = rsync --verbose --recursive --update --human-readable --partial --progress --preallocate --copy-links

#Systemd Stuff
alias ss = sudo systemctl
alias ssdr = sudo systemctl daemon-reload
alias sss = sudo systemctl status
alias ssr = sudo systemctl restart
alias sse = sudo systemctl enable
alias ssd = sudo systemctl disable
alias sudr = systemctl --user daemon-reload
alias sus = systemctl --user status
alias sur = systemctl --user restart
alias sue = systemctl --user enable --now
alias sud = systemctl --user disable

#Use hyperfine to time commands
alias time = hyperfine

#Udiskie
alias udm = udiskie-mount -a
def udum [] { for folder in [/run/media/wynand/*] { udiskie-umount --detach $folder } }

#Quick opening files with vim using my own script
def nvimf (file: string) {
    try {
        nvim (zoxide query -l | each { |item| fd -t f $file $item | first | str trim })
    } catch {
        echo "File not found: " $file
    }
}
alias n = nvimf
alias c = z

#Use XDG wget
alias wget = wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"

#. -------------- #
# >>>>> Git <<<<< #
#. -------------- #

# I make use of git-crypt
# Show status
def gs [] { git status }
