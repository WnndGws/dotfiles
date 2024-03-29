## Make sure to set /etc/zsh/zshenv to 'ZDOTDIR=/home/<user>/.config/zsh'

## Sourced always and first. Contain exported variables needed by other programs and scripts. Should be light weight since its run for every command

export LC_ALL='en_AU.utf8'

export PATH=/usr/local/bin:$HOME/.local/bin:$HOME/git/scripts/shell:$HOME/git/scripts/python:$HOME/git/fzf-scripts:$PATH
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""
export BROWSER=/usr/bin/wslview

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

###-----------###
###--- Vim ---###
###-----------###
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

###-----------------###
###--- XDG Paths ---###
###-----------------###
export XDG_CACHE_HOME=$HOME'/.cache'
export XDG_CONFIG_HOME=$HOME'/.config'
export XDG_DATA_HOME=$HOME'/.local/share'

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export _FASD_DATA="$XDG_CACHE_HOME/fasd/fasd"
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME"/password-store
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
#export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE=-
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/xinit/xinitrc

###-----------------###
###--- GPG Paths ---###
###-----------------###
# GPG now handled by systemctl --user
# https://eklitzke.org/using-gpg-agent-effectively
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
