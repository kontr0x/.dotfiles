#!/usr/bin/env bash

source ../utils.sh

## Backup and link i3 config
#
bck_cfg_and_link $HOME/.config/i3/config i3/config

## Check if i3wsr is installed and add it to i3 config
#
if command -v i3wsr $>/dev/null; then
	if ! grep -q -E 'exec_always --no-startup-id [a-zA-Z0-9\_\.\/\-]+/i3wsr' $dst; then
		echo -e "# Start i3wsr\nexec_always --no-startup-id $(which i3wsr)" >> $dst
	fi
fi

exit 0
