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
#Delete old recorded entry if new entry is a duplicate
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

#Edit commands by pressing spacebar when in normal mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd " " edit-command-line

#By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered. This results in a very jarring and frustrating transition between modes. Let's reduce this delay to 0.1 seconds.
export KEYTIMEOUT=1

###------------------------------###
###--- Sources that look nice ---###
###------------------------------###
# ------------------------------------------------------------------------------------------------ #
#find-the-command
#make sure to run pacman -Fy and systemctl enable pacman-files.timer
source /usr/share/doc/find-the-command/ftc.zsh
# ------------------------------------------------------------------------------------------------ #
#fasd shortcuts
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
#alias v='f -e "$EDITOR"'
#alias o='a -e $BROWSER'
#alias j='zz'
# ------------------------------------------------------------------------------------------------ #
# FZF Looks Good
fzf_base="/usr/share/fzf"
fzf_shell="$fzf_base"
#Auto-completion
if [[ ! "$DISABLE_FZF_AUTO_COMPLETION" == "true" ]]; then
    [[ $- == *i* ]] && source "${fzf_shell}/completion.zsh" 2> /dev/null
fi
##Key bindings
if [[ ! "$DISABLE_FZF_KEY_BINDINGS" == "true" ]]; then
    source "${fzf_shell}/key-bindings.zsh"
fi
unset fzf_base fzf_shell dir fzfdirs

##use fzf everywhere
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

export FZF_DEFAULT_OPTS="
--bind ctrl-d:half-page-down
--bind ctrl-u:half-page-up
--bind shift-right:preview-half-page-down
--bind shift-left:preview-half-page-up
--bind shift-down:preview-down
--bind shift-up:preview-up
--preview-window right,40%
-i --border
"
# ------------------------------------------------------------------------------------------------ #
#auto-suggestions
#Make sure have AUR package installed
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# ------------------------------------------------------------------------------------------------ #
#syntax highlighting
#Make sure have AUR package installed
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# ------------------------------------------------------------------------------------------------ #
#history substring search
#Make sure have AUR package installed
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#Search through history with arrow keys
bindkey "^[[A" history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd 'j' history-substring-search-down
# ------------------------------------------------------------------------------------------------ #
#you-should-use
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
# ------------------------------------------------------------------------------------------------ #
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
# ------------------------------------------------------------------------------------------------ #
# Autocompletions for wyman
eval "$(_WYMAN_COMPLETE=source_zsh wyman)"
# ------------------------------------------------------------------------------------------------ #
# Better vi(m) mode
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# shellcheck disable=SC2034,SC2153,SC2086,SC2155

# Above line is because shellcheck doesn't support zsh, per
# https://github.com/koalaman/shellcheck/wiki/SC1071, and the ignore: param in
# ludeeus/action-shellcheck only supports _directories_, not _files_. So
# instead, we manually add any error the shellcheck step finds in the file to
# the above line ...
# ------------------------------------------------------------------------------------------------ #
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

###--------------------###
###--- AUTOCOMPLETE ---###
###--------------------###
# This should be the last thing loaded in zshrc
autoload -Uz compinit
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
#fpath=("$XDG_CONFIG_HOME"/zsh/completions "$fpath")
zstyle :compinstall filename "$XDG_CONFIG_HOME"/zsh/.zshrc
#Test if zcompdump is older than 2hr, if it is create a new one, else omit the check for new functions since we updated recently enough
test "$(/usr/bin/find "$XDG_CONFIG_HOME"/zsh/.zcompdump -mmin -120)" && compinit -u -d "$XDG_CONFIG_HOME"/zsh/.zcompdump || compinit -C

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

#Completes the first in list of ambiguous completions
setopt MENU_COMPLETE
