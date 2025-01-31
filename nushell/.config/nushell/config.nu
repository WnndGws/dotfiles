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

#. ------------------ #
# >>>>> PLUGINS <<<<< #
#. ------------------ #
# Use starship prompt
source "~/.config/nushell/plugins/starship.nu"

#. ------------------ #
# >>>>> GENERAL <<<<< #
#. ------------------ #
# Source aliases
source "~/.config/nushell/aliases.nu"

# Use carapace for completions
source ~/.cache/carapace/init.nu

# Source zoxide
source ~/.config/nushell/plugins/zoxide.nu

use '/home/wynand/.config/broot/launcher/nushell/br' *
