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

# The default path add behavior is to prepend a directory so that it has higher precedence than the rest of the path
use std/util "path add"
path add "~/.local/bin"
path add "~/git/personal/scripts/rust/"
path add "~/git/personal/scripts/python/"
path add "~/git/personal/fzf-scripts"
path add "~/.cargo/bin"

# Show or hide the banner at shell start
$env.config.show_banner = true

# Use vi mode
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"

# Use trash
$env.config.rm.always_trash = true

# Use SSH for GPG (trim needed to remove newline)
$env.SSH_AUTH_SOCK = (gpgconf --list-dirs agent-ssh-socket | str trim)
