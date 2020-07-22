#!/usr/bin/env sh
## Runs a notmuch hook after downloading all mail

# Add 'new' and 'unread' tag to all new mail
notmuch new

# Tag all mail from me as sent
notmuch tag -new +sent -- from:wynand

# Tag uni
notmuch tag +uni -new -- to:uwa.edu.au

# Tag work
notmuch tag +work -new -- to:abilitycentre.com.au

# Tag the rest as unread and inbox
notmuch tag +inbox +unread -new -- tag:new

##------------------##
## Bacon Management ##
##------------------##
#notmuch tag -inbox +trash -- 'from:"donotreply@jora.com" date:"2017-01-01..yesterday" tag:inbox'
