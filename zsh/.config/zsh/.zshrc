# File reading order by zsh
#
# /etc/zsh/zshenv    ->    if present, always read first. Sets env for all users. should be lightweight and produce no output. This is where you set ZDOTDIR
#      ||
#      ||
#      \/
# $ZDOTDIR/.zshenv   ->    Sets env variables for each user. should be lightweight and produce no output
#      ||
#      ||
#      \/
# /etc/zsh/zprofile  ->    Execute commands for all users if the launch a LOGIN SHELL. in arch it contains a single line, dont remove this line!
#      ||
#      ||
#      \/
# $ZDOTDIR/.zprofile ->    execute users commands at start of a LOGIN SHELL. example usage is starting graphical profiles etc
#      ||
#      ||
#      \/
# /etc/zsh/zshrc     ->    Used for INTERACTIVE SHELL launch settings for all users
#      ||
#      ||
#      \/
# $ZDOTDIR/zshrc     ->    THIS FILE    ->    Used for INTERACTIVE SHELL launch settings for specific user

### ------------- ###
### ZSH VARIABLES ###
### ------------- ###
# Use XDG dirs for completion and history files
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
[ -d "$XDG_CONFIG_HOME"/zsh ] || mkdir -p "$XDG_CONFIG_HOME"/zsh

#Use starship
eval "$(starship init zsh)"

#Automatic tmux renaming
tmux-window-name() {
    ("$TMUX_PLUGIN_MANAGER_PATH"/tmux-window-name/scripts/rename_session_windows.py &)
}

#Adapted from https://srstevenson.com/posts/zsh-terminal-title/
#https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
#Automatic window renaming
autoload -Uz add-zsh-hook
_precmd_title() {
    # NOTE: this variable is checked on the machine you are ssh-ed into
    if [[ -n "$SSH_CONNECTION" ]]; then
        print -Pn "\e]0;ssh:%n@%m:%~\a"
    else
        print -Pn "\e]0;zsh:%~\a"
    fi
}
_preexec_title() {
    if [[ -n "$SSH_CONNECTION" ]]; then
        print -Pn "\e]0;ssh:%n@%m:%~\a"
    else
        print -Pn "\e]0;zsh:%~\a"
    fi
}
add-zsh-hook precmd _precmd_title
add-zsh-hook preexec _preexec_title

#Aliases
source "$XDG_CONFIG_HOME"/zsh/.zaliases

###---------------###
###--- HISTORY ---###
###---------------###
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=100000
SAVEHIST=100000
#Write the history file in the ":start:elapsed;command" format
setopt EXTENDED_HISTORY
#Write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY
#Share history between all sessions
setopt SHARE_HISTORY
#Don't write duplicate entries in the history file
setopt HIST_SAVE_NO_DUPS
#Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
#Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS
#Delete old recorded entry if new command is a duplicate
setopt HIST_IGNORE_ALL_DUPS

###--------------###
###--- SETOPT ---###
###--------------###
#allow cahnge of dir without needing cd
setopt AUTO_CD

#auto-ls
function chpwd() {
    emulate -L zsh
    #exa --color always --color-scale
    ls -la
}

#shuts up zsh
unset BEEP

#Explicitly sets keys to vim mode
bindkey -v

#By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered. This results in a very jarring and frustrating transition between insert and normal mode. Let's reduce this delay to 0.1 seconds.
export KEYTIMEOUT=1

###--------------------###
###--- AUTOCOMPLETE ---###
###--------------------###
# NOTE: moved ABOVE the plugin sources. fzf-tab must be sourced AFTER compinit
# but BEFORE zsh-autosuggestions / zsh-syntax-highlighting.
fpath=("$XDG_CONFIG_HOME/zsh/completions" "${fpath[@]}")
autoload -Uz compinit
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle :compinstall filename "$XDG_CONFIG_HOME"/zsh/.zshrc
# Single compinit call: use the fast -C path (skip security check / rescan) if
# the dump is younger than 2 hours, otherwise do a full rebuild.
if [[ -n $(/usr/bin/find "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION" -mmin -120 2>/dev/null) ]]; then
    compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
else
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
fi

#Case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
#
#Partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

#Double TAB gives menu
zstyle ':completion:*' menu select

#Move in menu with vim keys
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#Show completions grouped by source (file/command/option/...) as fzf headers
#NOTE: no zsh escape sequences (%F{red}%d%f) here, fzf-tab ignores them
zstyle ':completion:*:descriptions' format '[%d]'
# MENU_COMPLETE removed: it auto-inserts the first ambiguous match and fights fzf-tab

###---------------------------###
###--- ALIAS ORIGIN TRACKING ---###
###---------------------------###
# zsh doesn't record where an alias was defined, so snapshot the alias table
# around each plugin source and tag anything newly defined.
typeset -gA _alias_origin
_source_tracked() {
    local before=(${(k)aliases})
    source "$@"
    local a
    for a in ${${(k)aliases}:*before}; do
        _alias_origin[$a]="$1"
    done
}

# Look up where a command came from
wherefrom() {
    local c=$1
    if [[ -n $_alias_origin[$c] ]]; then
        print -u2 "alias, defined in: $_alias_origin[$c]"
        print "  expands to: ${aliases[$c]}"
    elif (( $+functions[$c] )); then
        print -u2 "function"
        whence -v $c
    else
        whence -v $c
    fi
}

###------------------------------###
###--- Sources that look nice ---###
###------------------------------###
# --------------------------------------------------------------------------- #
#find-the-command
#make sure to run pacman -Fy and systemctl enable pacman-files.timer
source /usr/share/doc/find-the-command/ftc.zsh
# --------------------------------------------------------------------------- #
#fasd shortcuts
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
# --------------------------------------------------------------------------- #
#FZF Looks Good
#use fzf everywhere
# now correctly AFTER compinit, and before autosuggestions/syntax-highlighting
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
# colour the [file]/[command]... group headers in fzf
zstyle ':fzf-tab:*' fzf-flags --color=header:3
# --------------------------------------------------------------------------- #
#auto-suggestions
#Make sure have AUR package installed
_source_tracked /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# --------------------------------------------------------------------------- #
#history substring search
#Make sure have AUR package installed
_source_tracked /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# --------------------------------------------------------------------------- #
#you-should-use
_source_tracked /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
# --------------------------------------------------------------------------- #
#syntax highlighting
#Make sure have AUR package installed
_source_tracked /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# --------------------------------------------------------------------------- #
#forgit
#fzf git commands
_source_tracked /usr/share/zsh/plugins/forgit-git/forgit.plugin.zsh
# --------------------------------------------------------------------------- #
#glob-alias
#https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
    zle _expand_alias
    zle expand-word
    zle self-insert
}
zle -N globalias
# control-space expands all aliases, including global
bindkey -M viins "^ " globalias
# --------------------------------------------------------------------------- #
# Better vi(m) mode
# NOTE: moved to last, after syntax highlighting, per zsh-vi-mode's README
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# zsh-vi-mode replaces the keymaps when it loads, so user bindings must be
# (re)done inside its after-init hook, not before it.
zvm_after_init() {
    # Edit command line with space in normal mode
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd " " edit-command-line

    # history substring search with arrow keys + vicmd hjkl
    bindkey "^[[A" history-substring-search-up
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey "^[[B" history-substring-search-down
    bindkey -M vicmd 'j' history-substring-search-down

    # control-space expands all aliases, including global
    bindkey -M viins "^ " globalias
}

# shellcheck disable=SC2034,SC2153,SC2086,SC2155

# Above line is because shellcheck doesn't support zsh, per
# https://github.com/koalaman/shellcheck/wiki/SC1071, and the ignore: param in
# ludeeus/action-shellcheck only supports _directories_, not _files_. So
# instead, we manually add any error the shellcheck step finds in the file to
# the above line ...
# --------------------------------------------------------------------------- #
# Source this in your ~/.zshrc
autoload -U add-zsh-hook
zmodload zsh/datetime 2>/dev/null

### --------------------- ###
### --- SSH/GPG STUFF --- ###
### --------------------- ###

# TTY is a zsh global var, not exported
export GPG_TTY="${TTY:-$(tty)}"

# Set the default paths to gpg-agent files.
_gpg_agent_conf="${GNUPGHOME:-$HOME/.gnupg}/gpg-agent.conf"

# use custom env var _GPG_AGENT_SOCK to remember socket location
if [[ -z $_GPG_AGENT_SOCK ]]; then
    export _GPG_AGENT_SOCK=$(gpgconf --list-dirs agent-socket)
fi

# launch gpg-agent manually, in case it's used as agent for SSH
if [[ ! -S $_GPG_AGENT_SOCK ]]; then
    gpgconf --launch gpg-agent 2>/dev/null
fi

# Attach the SSH-agent to gpg-agent
unset SSH_AGENT_PID 2>/dev/null
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    if [[ -z $_GPG_AGENT_SSH_SOCK ]]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    else
        export SSH_AUTH_SOCK="$_GPG_AGENT_SSH_SOCK"
    fi
fi

# Updates the gpg-agent TTY before every command since there's no way to detect this info in the ssh-agent protocol
function _gpg-agent-update-tty {
    gpg-connect-agent UPDATESTARTUPTTY /bye &>/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _gpg-agent-update-tty

if [[ -n $SSH_TTY ]]; then
    # Force use ncurses-based prompt inside SSH
    export PINENTRY_USER_DATA="USE_CURSES=1"

    # Remove socket file for next gpg-agent remote forwarding
    # in case that `StreamLocalBindUnlink yes` is not set in sshd_config
    if [[ $SHLVL == 1 ]]; then
        function _gpg-agent-clean-socket {
            if [[ -z $_GPG_AGENT_SOCK ]]; then
                export _GPG_AGENT_SOCK=$(gpgconf --list-dirs agent-socket)
            fi

            if [[ -S $_GPG_AGENT_SOCK ]]; then
                gpgconf --kill gpg-agent 2>/dev/null
                command rm -f "$_GPG_AGENT_SOCK" 2>/dev/null
            fi
        }
        autoload -Uz add-zsh-hook
        add-zsh-hook zshexit _gpg-agent-clean-socket
    fi
fi

# Clean up.
unset _gpg_agent_conf

###------------------------###
###--- CUSTOM FUNCTIONS ---###
###------------------------###
for f in ~/git/scripts/shell_source/*(.); source $f
