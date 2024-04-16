#WHERE SHOULD STUFF GO:
#.zshenv: Sourced always and first. Contain exported variables needed by other programs and scripts. Should be light weight since its run for every command
#export ZDOTDIR=$HOME/.config/zsh in /etc/zsh/zshenv
#.zshrc: Sourced for interactive shell. Put anything that makes typing in commands easier and nicer looking
#.zlogin: sourced at login but after zshrc, whether interactive or not. 
#.zaliases: sourced inside .zshrc. Gives all my interactive shell aliases
#
###---------------------------------------------------###
###--- ENV Variables that extend interactive shell ---###
###---------------------------------------------------###
#If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Use starship
eval "$(starship init zsh)"

#XDG Paths
export FZF_DEFAULT_OPTS='-i --border' #Left in .zshrc since borders are interactive only

#Aliases
source $XDG_CONFIG_HOME/zsh/.zaliases

#GPG
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1

#Completions
fpath=(~/.config/zsh/completions $fpath)

###--------------###
###--- History---###
###--------------###
HISTFILE=~/.cache/zsh/histfile
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
#Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS

###--------------###
###--- Setopts---###
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

#Edit commands by pressing spacebar when in normal mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd " " edit-command-line

#By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered. This results in a very jarring and frustrating transition between modes. Let's reduce this delay to 0.1 seconds.
export KEYTIMEOUT=1

###----------------------###
###--- AutoCompletions---###
###----------------------###
zstyle :compinstall filename '$XDG_CONFIG_HOME/zsh/.zshrc'
autoload -Uz compinit
#Test if zcompdump is older than 2hr, if it is create a new one, else omit the check for new functions since we updated recently enough
test "$(/usr/bin/find $XDG_CONFIG_HOME/zsh/.zcompdump -mmin +120)" && compinit || compinit -C

#Case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

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

#Completes the first in list of ambiguous completions
setopt MENU_COMPLETE

###------------------------------###
###--- Sources that look nice ---###
###------------------------------###

#find-the-command
#make sure to run pacman -Fy and systemctl enable pacman-files.timer
source /usr/share/doc/find-the-command/ftc.zsh

#fasd shortcuts
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
#alias v='f -e "$EDITOR"'
#alias o='a -e $BROWSER'
#alias j='zz'

#fzf
fzf_base="/usr/share/fzf"
fzf_shell="${fzf_base}"
#Auto-completion
if [[ ! "$DISABLE_FZF_AUTO_COMPLETION" == "true" ]]; then
     [[ $- == *i* ]] && source "${fzf_shell}/completion.zsh" 2> /dev/null
fi
# Key bindings
if [[ ! "$DISABLE_FZF_KEY_BINDINGS" == "true" ]]; then
    source "${fzf_shell}/key-bindings.zsh"
fi
unset fzf_base fzf_shell dir fzfdirs

#use fzf everywhere
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

#auto-suggestions
#Make sure have AUR package installed
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

#syntax highlighting
#Make sure have AUR package installed
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

#history substring search
#Make sure have AUR package installed
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#Search through history with arrow keys
bindkey "^[[A" history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd 'j' history-substring-search-down

#you-should-use
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

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

# Autocompletions for wyman
eval "$(_WYMAN_COMPLETE=source_zsh wyman)"

# Better vi(m) mode
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# shellcheck disable=SC2034,SC2153,SC2086,SC2155

# Above line is because shellcheck doesn't support zsh, per
# https://github.com/koalaman/shellcheck/wiki/SC1071, and the ignore: param in
# ludeeus/action-shellcheck only supports _directories_, not _files_. So
# instead, we manually add any error the shellcheck step finds in the file to
# the above line ...

# Source this in your ~/.zshrc
autoload -U add-zsh-hook

zmodload zsh/datetime 2>/dev/null

# If zsh-autosuggestions is installed, configure it to use Atuin's search. If
# you'd like to override this, then add your config after the $(atuin init zsh)
# in your .zshrc
_zsh_autosuggest_strategy_atuin() {
    suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix -- "$1")
}

if [ -n "${ZSH_AUTOSUGGEST_STRATEGY:-}" ]; then
    ZSH_AUTOSUGGEST_STRATEGY=("atuin" "${ZSH_AUTOSUGGEST_STRATEGY[@]}")
else
    ZSH_AUTOSUGGEST_STRATEGY=("atuin")
fi

export ATUIN_SESSION=$(atuin uuid)
ATUIN_HISTORY_ID=""

_atuin_preexec() {
    local id
    id=$(atuin history start -- "$1")
    export ATUIN_HISTORY_ID="$id"
    __atuin_preexec_time=${EPOCHREALTIME-}
}

_atuin_precmd() {
    local EXIT="$?" __atuin_precmd_time=${EPOCHREALTIME-}

    [[ -z "${ATUIN_HISTORY_ID:-}" ]] && return

    local duration=""
    if [[ -n $__atuin_preexec_time && -n $__atuin_precmd_time ]]; then
        printf -v duration %.0f $(((__atuin_precmd_time - __atuin_preexec_time) * 1000000000))
    fi

    (ATUIN_LOG=error atuin history end --exit $EXIT ${duration:+--duration=$duration} -- $ATUIN_HISTORY_ID &) >/dev/null 2>&1
    export ATUIN_HISTORY_ID=""
}

_atuin_search() {
    emulate -L zsh
    zle -I

    # swap stderr and stdout, so that the tui stuff works
    # TODO: not this
    local output
    # shellcheck disable=SC2048
    output=$(ATUIN_SHELL_ZSH=t ATUIN_LOG=error atuin search $* -i -- $BUFFER 3>&1 1>&2 2>&3)

    zle reset-prompt

    if [[ -n $output ]]; then
        RBUFFER=""
        LBUFFER=$output

        if [[ $LBUFFER == __atuin_accept__:* ]]
        then
            LBUFFER=${LBUFFER#__atuin_accept__:}
            zle accept-line
        fi
    fi
}
_atuin_search_vicmd() {
    _atuin_search --keymap-mode=vim-normal
}
_atuin_search_viins() {
    _atuin_search --keymap-mode=vim-insert
}

_atuin_up_search() {
    # Only trigger if the buffer is a single line
    if [[ ! $BUFFER == *$'\n'* ]]; then
        _atuin_search --shell-up-key-binding "$@"
    else
        zle up-line
    fi
}
_atuin_up_search_vicmd() {
    _atuin_up_search --keymap-mode=vim-normal
}
_atuin_up_search_viins() {
    _atuin_up_search --keymap-mode=vim-insert
}

add-zsh-hook preexec _atuin_preexec
add-zsh-hook precmd _atuin_precmd

zle -N atuin-search _atuin_search
zle -N atuin-search-vicmd _atuin_search_vicmd
zle -N atuin-search-viins _atuin_search_viins
zle -N atuin-up-search _atuin_up_search
zle -N atuin-up-search-vicmd _atuin_up_search_vicmd
zle -N atuin-up-search-viins _atuin_up_search_viins

# These are compatibility widget names for "atuin <= 17.2.1" users.
zle -N _atuin_search_widget _atuin_search
zle -N _atuin_up_search_widget _atuin_up_search

bindkey -M emacs '^r' atuin-search
bindkey -M viins '^r' atuin-search-viins
bindkey -M vicmd '/' atuin-search
bindkey -M emacs '^[[A' atuin-up-search
bindkey -M vicmd '^[[A' atuin-up-search-vicmd
bindkey -M viins '^[[A' atuin-up-search-viins
bindkey -M emacs '^[OA' atuin-up-search
bindkey -M vicmd '^[OA' atuin-up-search-vicmd
bindkey -M viins '^[OA' atuin-up-search-viins
bindkey -M vicmd 'k' atuin-up-search-vicmd
