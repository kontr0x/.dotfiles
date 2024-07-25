#!/usr/bin/env bash

CONF_FILE="dconf-kb-binds.conf"

if command -v dconf &>/dev/null; then
	# dconf dump /org/cinnamon/desktop/keybindings/ > $CONF_FILE 
	dconf load /org/cinnamon/desktop/keybindings/ < $CONF_FILE
else
	echo "ERROR: dconf command not available, can't apply custom keybinds"
	exit 1
fi

exit 0
