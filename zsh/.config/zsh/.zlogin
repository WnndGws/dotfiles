# Sourced AFTER .zshrc

###--------------------###
###--- FZF and FASD ---###
###--------------------###
# Sourcing here since even though it is interactive only theres no sourcing where only interative can be sourced
#FASD
## Init fasd from cache if it exists
fasd_cache=$XDG_CACHE_HOME/fasd-init-zsh
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $fasd_cache
fi
source $fasd_cache
unset fasd_cache

#FZF
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

cd $HOME
