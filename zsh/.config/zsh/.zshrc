#
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
#Use starship
eval "$(starship init zsh)"

#XDG Paths
export FZF_DEFAULT_OPTS='-i --border' #Left in .zshrc since borders are interactive only

#Aliases
source $XDG_CONFIG_HOME/zsh/.zaliases

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
alias v='f -e "$EDITOR"'
alias o='a -e $BROWSER'
alias j='zz'

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
