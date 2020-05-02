## Sourced always and first. Contain exported variables needed by other programs and scripts. Should be light weight since its run for every command

export PATH=/usr/local/bin:$HOME/.local/share/cargo/bin:$HOME/.local/share/bin:$PATH
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

###-----------###
###--- Vim ---###
###-----------###
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

###-----------------###
###--- XDG Paths ---###
###-----------------###
export XDG_CACHE_HOME=$HOME'/.cache'
export XDG_CONFIG_HOME=$HOME'/.config'
export XDG_DATA_HOME=$HOME'/.local/share'

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export _FASD_DATA="$XDG_CACHE_HOME/fasd/fasd"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export PYLINTHOME="$XDG_CACHE_HOME"/pylint 
export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/xinit/xinitrc"

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
