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
# $ZDOTDIR/.zprofile ->    THIS FILE    -> execute users commands at start of a LOGIN SHELL. example usage is starting graphical profiles etc
#      ||
#      ||
#      \/
# /etc/zsh/zshrc     ->    Used for INTERACTIVE SHELL launch settings for all users
#      ||
#      ||
#      \/
# $ZDOTDIR/zshrc     ->    Used for INTERACTIVE SHELL launch settings for specific user
