# config.nu
# config.nu is typically used to:
#   * override default Nushell settings
#   * define (or import) custom commands
#   * run any other startup tasks.
#
# File load order:
# env.nu    config.nu    login.nu
#              ^
#              |
#              |
#              --- aliases.nu
#

# Use starship prompt
source "~/.config/nushell/plugins/starship.nu"
# Source aliases
source "~/.config/nushell/aliases.nu"
