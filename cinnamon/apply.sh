#!/usr/bin/env bash

## Check if cinnamon is the current desktop environment
#
if [ "$XDG_SESSION_DESKTOP" != "X-Cinnamon" ]; then
	echo "ERROR: cinnamon is installed but not currently used, aborting"
	exit 1
fi

## Local variables
#
CONF_FILE="dconf-kb-binds.conf"

if command -v dconf &>/dev/null; then
	# dconf dump /org/cinnamon/desktop/keybindings/ > $CONF_FILE 
	dconf load /org/cinnamon/desktop/keybindings/ < $CONF_FILE
else
	echo "ERROR: dconf command not available, can't apply custom keybinds"
	exit 1
fi

exit 0
