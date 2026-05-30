import builtins, operator, typing
import os, sys, io, errno, ctypes
import struct, re, shlex, shutil, textwrap, functools
from datetime import datetime, timedelta
import zoneinfo
from zoneinfo import ZoneInfo
import pathlib
from pathlib import Path

from xonsh.events import events
from xonsh.procs.specs import SpecAttrDecoratorAlias
from xonsh.tools import unthreadable

### GENERAL STUFF ---------------------------------------------------------------------
# These variables are set to lambdas, and are not exported to subprocesses
# unless they have been evaluated at least once, it seems.
$HOSTNAME
$HOSTTYPE

# Use Neovim for everything.
$EDITOR = $(which nvim)
$VISUAL = $EDITOR
$SYSTEMD_EDITOR = $EDITOR
$NETCTL_EDITOR = $EDITOR

$MANPAGER = 'batman'

def exit_code():
	try:
		return str(@.lastcmd.rtn)
	except (AttributeError, NameError):
		return '0'

def exit_color():
	try:
		return '{RED}' if @.lastcmd.rtn != 0 else '{GREEN}'
	except (AttributeError, NameError):
		return '{GREEN}'

### ENV VARIABLES ---------------------------------------------------------------------
# Any variables not set here are because I am happy with the defaults
# found at https://xon.sh/envvars.html

$PATH = ('/usr/local/sbin', '/usr/local/bin', '/usr/bin', '$HOME/.local/bin')

### ------------ ###
### XDG SETTINGS ###
### ------------ ###
$XDG_CACHE_HOME = '~/.cache'
$XDG_CONFIG_HOME = '~/.config'
$XDG_DATA_DIRS = ['/usr/share', '/usr/local/share']
$XDG_DATA_HOME = '~/.local/share'
$XDG_STATE_HOME = '~/.local/state'
$XONSH_CONFIG_DIR = '$XDG_CONFIG_HOME/xonsh'
$XONSH_DATA_DIR = '$XDG_DATA_HOME/xonsh'

$CARGO_HOME="$XDG_DATA_HOME/cargo"
$FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
$GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
$GOMODCACHE="$XDG_CACHE_HOME/go/mod"
$GOPATH="$XDG_DATA_HOME/go"
$GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
$INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
$LESSHISTFILE="$XDG_CACHE_HOME/less/history"
$MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
$NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
$PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
$PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
$PYTHONUSERBASE="$XDG_DATA_HOME/python"
$PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
$RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
$RUFF_CACHE_DIR="$XDG_CACHE_HOME/ruff"
$STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
$STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
$TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME/tmux/plugins"
$WGETRC="$XDG_CONFIG_HOME/wgetrc"
$_FASD_DATA="$XDG_CACHE_HOME/fasd/fasd"


### ---------------- ###
### GENERAL SETTINGS ###
### ---------------- ###
$UPDATE_OS_ENVIRON = True
$XONSHRC = ['$XONSH_CONFIG_DIR/xonsh/rc.xsh']
$XONSHRC_DIR = ['$XONSH_SYS_CONFIG_DIR/rc.d', '$XONSH_CONFIG_DIR/rc.d']
$XONSH_MODE = 'interactive'
$XONSH_STORE_STDIN = True

### ------------------- ###
### Subprocess Settings ###
### ------------------- ###
$XONSH_APPEND_NEWLINE = $XONSH_INTERACTIVE
$XONSH_BUILTINS_TO_CMD = False
$XONSH_CAPTURE_ALWAYS = True
$XONSH_SUBPROC_CAPTURED_PRINT_STDERR = True
$XONSH_SUBPROC_CMD_RAISE_ERROR = True
$XONSH_SUBPROC_RAISE_ERROR = True

### ------------- ###
### Jobs Settings ###
### ------------- ###
$AUTO_CONTINUE = False

### ---------------------------- ###
### Language and locale settings ###
### ---------------------------- ###
$LANG = 'en_AU.UTF-8'
$LC_COLLATE = 'en_AU.UTF-8'
$LC_CTYPE = 'en_AU.UTF-8'
$LC_MESSAGES = 'en_AU.UTF-8'
$LC_MONETARY = 'en_AU.UTF-8'
$LC_NUMERIC = 'en_AU.UTF-8'
$LC_TIME = 'en_AU.UTF-8'
$XONSH_DATETIME_FORMAT = '%Y-%m-%d %H:%M'

### -------------- ###
### Cache Settings ###
### -------------- ###
$COMMANDS_CACHE_SAVE_INTERMEDIATE = False
$ENABLE_COMMANDS_CACHE = False
$XONSH_CACHE_EVERYTHING = False
$XONSH_CACHE_SCRIPTS = False
$XONSH_COMMANDS_CACHE_TRACE = False

### ----------- ###
### cd Behavior ###
### ----------- ###
$AUTO_CD = True
$AUTO_PUSHD = True
$CDPATH = ('/home/wynand/', '/home/wynand/git/')
$COMPLETE_DOTS = 'matching'
$DIRSTACK_SIZE = 20
$PUSHD_SILENT = True

### -------------------- ###
### Interpreter Behavior ###
### -------------------- ###
$DOTGLOB = True
$EXPAND_ENV_VARS = True
$GLOB_SORTED = True

### ------------------ ###
### Interactive Prompt ###
### ------------------ ###
$BOTTOM_TOOLBAR = ''
$DYNAMIC_CWD_ELISION_CHAR = '…'
$INDENT = '    '
$MULTILINE_PROMPT = ''
$PROMPT_REFRESH_INTERVAL = 0.0
$RIGHT_PROMPT = ''
$SUPPRESS_BRANCH_TIMEOUT_MESSAGE = False
$VC_GIT_INCLUDE_UNTRACKED = True
$VC_HG_SHOW_BRANCH = True
$XONSH_HISTORY_MATCH_ANYWHERE = True
$XONSH_PROMPT_SHOW_SUBPROC_ERROR = True
$XONSH_SUPPRESS_WELCOME = True

### -------------------- ###
### Prompt Toolkit shell ###
### -------------------- ###
$AUTO_SUGGEST_IN_COMPLETIONS = True
$MOUSE_SUPPORT = True
$VI_MODE = True
$XONSH_AUTOPAIR = True
$XONSH_COPY_ON_DELETE = True
$XONSH_CTRL_BKSP_DELETION = True
$XONSH_PROMPT_AUTO_SUGGEST = True
$XONSH_PROMPT_CURSOR_SHAPE = 'modal-vi-mode-only'
$XONSH_USE_SYSTEM_CLIPBOARD = True

### ------------------- ###
### Asynchronous Prompt ###
### ------------------- ###
$ASYNC_INVALIDATE_INTERVAL = 0.05
$ENABLE_ASYNC_PROMPT = False

### -------------------------- ###
### Interactive Prompt History ###
### -------------------------- ###
$XONSH_HISTORY_SAVE_CWD = True

### ----------------------- ###
### Tab-completion behavior.###
### ----------------------- ###
$ALIAS_COMPLETIONS_OPTIONS_BY_DEFAULT = True
$ALIAS_COMPLETIONS_OPTIONS_LONGEST = True
$CMD_COMPLETIONS_SHOW_DESC = True
$COMPLETIONS_BRACKETS = True
$COMPLETION_QUERY_LIMIT = 1000
$FUZZY_PATH_COMPLETION = True
$SUBSEQUENCE_PATH_COMPLETION = True
$XONSH_COMPLETER_DIRS = '$XONSH_CONFIG_DIR/completions'
$XONSH_COMPLETER_MODE = 'substring_tier'
$XONSH_COMPLETER_TRACE = False

#### ---------------------------- ###
### Prompt Toolkit tab-completion ###
#### ---------------------------- ###
$COMPLETIONS_CONFIRM = False
$COMPLETIONS_DISPLAY = 'single'
$COMPLETIONS_MENU_ROWS = 5
$COMPLETION_IN_THREAD = True
$COMPLETION_MODE = 'menu-complete'
$UPDATE_COMPLETIONS_ON_KEYPRESS = False


### ALIASES ---------------------------------------------------------------------------
#### ------ ####
#### Pacman ####
#### ------ ####
aliases["archdate"] = {
    "alias": "pikaur --sync --refresh --sysupgrade --rebuild --needed && pikaur --deptest && tldr --update & checkrebuild && sudo pacleaner --uninstalled --number 1 --delete --no-confirm && pkill -SIGRTMIN+2 waybar",
    "doc": "Update Arch",
}
aliases["ad"] = {"alias": "archdate", "doc": "Shortcut for archdate"}
aliases["remove_database_lock"] = {
    "alias": "sudo /bin/rm /var/lib/pacman/db.lck",
    "doc": "Remove db lock so that archdate can continue",
}
aliases["rdl"] = {"alias": "remove_database_lock", "doc": ""}
aliases["paorph"] = {"alias": "pacman --query --unrequired --deps --quiet", "doc": ""}
aliases["po"] = {"alias": "paorph", "doc": ""}
aliases["porm"] = {
    "alias": "pacman --query --unrequired --deps --quiet | xargs -I{} pikaur -R --noconfirm {}; pacman --query --unrequired --deps --quiet | xargs -I{} pikaur -R --noconfirm {}; pacman --query --unrequired --deps --quiet | xargs -I{} pikaur -R --noconfirm {}",
    "doc": "",
}
aliases["pare"] = {"alias": "$HOME/git/scripts/fuzzy/fpikrm -s", "doc": ""}
aliases["pin"] = {"alias": "pikaur -S --noconfirm", "doc": ""}
aliases["pq"] = {"alias": "pikaur -Qi | rg -B3 -A3", "doc": ""}
aliases["pir"] = {"alias": "pikaur -S --rebuild", "doc": ""}
aliases["pcc"] = {"alias": "sudo rm -rf /var/cache/pacman/pkg/", "doc": ""}

#### --- ####
#### Git ####
#### --- ####
aliases["gi"] = {
    "alias": "cp $HOME/git/dotfiles/git/.config/git/gitignore .gitignore",
    "doc": "",
}
aliases["gs"] = {"alias": "git status", "doc": ""}

#### --------- ####
#### Shortcuts ####
#### --------- ####
aliases["ncdu"] = {"alias": "Use dua-cli instead", "doc": ""}
aliases["zl"] = {"alias": "zathura", "doc": ""}
aliases["bm"] = {"alias": "batman", "doc": ""}
aliases["bw"] = {"alias": "batwatch", "doc": ""}
aliases["bd"] = {"alias": "batdiff", "doc": ""}
aliases["cp"] = {"alias": "cp -i", "doc": ""}
aliases["mv"] = {"alias": "mv -i", "doc": ""}
aliases["cx"] = {"alias": "chmod +x", "doc": ""}
aliases["dd"] = {"alias": "sudo /usr/bin/dd status=progress conv=fsync", "doc": ""}
aliases["lsa"] = {"alias": "eza --header --group --group-directories-first --classify --binary --all --color always --color-scale all", "doc": ""}
aliases["ll"] = {
    "alias": "eza --all --header --group --group-directories-first --classify --binary --color always --color-scale all --long",
    "doc": "",
}
aliases["ls"] = {"alias": "eza --color always --color-scale all --header --group --group-directories-first --classify --binary", "doc": ""}
aliases["lt"] = {
    "alias": "eza --color always --color-scale all --tree --level=5 --header --group --group-directories-first --classify --binary",
    "doc": "",
}
aliases["lta"] = {
    "alias": "eza --all --color always --color-scale all --tree --level=5 --header --group --group-directories-first --classify --binary",
    "doc": "",
}
aliases["md"] = {"alias": "/usr/bin/mkdir -p", "doc": ""}
aliases["mm"] = {"alias": "wyman", "doc": ""}
aliases["nv"] = {"alias": "nvim", "doc": ""}
aliases["sv"] = {"alias": "sudo nvim", "doc": ""}
aliases["rg"] = {"alias": "rg --hidden -i --multiline", "doc": ""}
aliases["fd"] = {"alias": "fd --hidden --no-ignore", "doc": ""}
aliases["rs"] = {
    "alias": "rsync --verbose --recursive --update --human-readable --partial --progress --preallocate --copy-links",
    "doc": "",
}
aliases["scc"] = {"alias": "sleepcount -c", "doc": ""}
aliases["ss"] = {"alias": "sudo systemctl", "doc": ""}
aliases["ssdr"] = {"alias": "sudo systemctl daemon-reload", "doc": ""}
aliases["sss"] = {"alias": "sudo systemctl status", "doc": ""}
aliases["ssr"] = {"alias": "sudo systemctl restart", "doc": ""}
aliases["sse"] = {"alias": "sudo systemctl enable", "doc": ""}
aliases["ssd"] = {"alias": "sudo systemctl disable", "doc": ""}
aliases["time"] = {"alias": "hyperfine", "doc": ""}
aliases["udm"] = {"alias": "udiskie-mount -a", "doc": ""}

#### ------ ####
#### Python ####
#### ------ ####
aliases["new_env"] = {
    "alias": "uv init && uv venv && source .venv/bin/activate",
    "doc": "",
}
aliases["source_env"] = {"alias": "source .venv/bin/activate", "doc": ""}
aliases["ne"] = {"alias": "new_env", "doc": ""}
aliases["se"] = {"alias": "source_env", "doc": ""}

#### --------------- ####
#### String commands ####
#### --------------- ####
aliases["lg"] = {
    "alias": 'git fetch && print -Pn "\\e]0;lazygit:%~\a" && lazygit',
    "doc": "",
}
aliases["ww"] = {
    "alias": "cd ~/git/git-wiki/ && git sync && nvim +NvimTreeOpen",
    "doc": "",
}
