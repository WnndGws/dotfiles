# env.nu
#
# env.nu is typically used to:
#   * used to override or set environment variables
#
# File load order:
# env.nu    config.nu    login.nu
#   ^
#   |
#   |
#

# Set XDG user dirs
export-env { load-env {
    XDG_DATA_HOME: ($env.HOME | path join ".local" "share")
    XDG_CONFIG_HOME: ($env.HOME | path join ".config")
    XDG_STATE_HOME: ($env.HOME | path join ".local" "state")
    XDG_CACHE_HOME: ($env.HOME | path join ".cache")
    XDG_DOCUMENTS_DIR: ($env.HOME | path join "Documents")
    XDG_DOWNLOAD_DIR: ($env.HOME | path join "Downloads")
}}

export-env { load-env {
    CARGO_HOME: ($env.XDG_DATA_HOME | path join "cargo")
    GNUPGHOME: ($env.XDG_CONFIG_HOME | path join "gnupg")
    GOPATH: ($env.XDG_DATA_HOME | path join "go")
    GRIPHOME: ($env.XDG_CONFIG_HOME | path join "grip")
    GTK2_RC_FILES: ($env.XDG_CONFIG_HOME | path join "gtk-2.0" "gtkrc")
    LESSHISTFILE: ($env.XDG_CACHE_HOME | path join "less" "history")
    NPM_CONFIG_USERCONFIG: ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")
    PASSWORD_STORE_DIR: ($env.XDG_DATA_HOME | path join "pass")
    QUICKEMU_HOME: ($env.XDG_DATA_HOME | path join "quickemu")
    RUSTUP_HOME: ($env.XDG_CONFIG_HOME | path join "rustup")
    SSH_AGENT_TIMEOUT: 300
    SSH_KEYS_HOME: ($env.HOME | path join ".ssh" "keys")
    _JAVA_OPTIONS: $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME | path join java)"
    _Z_DATA: ($env.XDG_DATA_HOME | path join "z")
}}

# The default path add behavior is to prepend a directory so that it has higher precedence than the rest of the path
use std/util "path add"
path add "~/git/scripts/rust/"
path add "~/git/scripts/python/"
path add "~/git/fzf-scripts"
path add ($env.XDG_DATA_HOME | path join "npm" "bin")
path add ($env.CARGO_HOME | path join "bin")
path add ($env.HOME | path join ".local" "bin")
$env.PATH = ($env.PATH | uniq)

# FZF
$env.FZF_DEFAULT_OPTS = "
--bind ctrl-d:half-page-down
--bind ctrl-u:half-page-up
--bind shift-right:preview-half-page-down
--bind shift-left:preview-half-page-up
--bind shift-down:preview-down
--bind shift-up:preview-up
--preview-window right,40%
"

# Show or hide the banner at shell start
$env.config.show_banner = true

# Use vi mode
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.EDITOR = 'nvim'
$env.VISUAL = $env.EDITOR

# Use trash
$env.config.rm.always_trash = true

# Use carapace for completion
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# Use zoxide for quick nav
zoxide init nushell | save -f ~/.config/nushell/plugins/zoxide.nu

# Set SSH Stuff
## Launch gpg-agent if it hasnt already
if not (gpgconf --list-dirs agent-ssh-socket | path exists) {
  gpgconf --launch gpg-agent
}

## Attach the SSH-agent to gpg-agent
if not ("SSH_AUTH_SOCK" in $env) {
    $env.SSH_AUTH_SOCK = (gpgconf --list-dirs agent-ssh-socket)
}


$env.GPG_TTY = (tty | str trim)
gpg-connect-agent updatestartuptty /bye | ignore
