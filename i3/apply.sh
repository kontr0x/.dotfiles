#!/usr/bin/env bash

source ./utils.sh
source ../utils.sh

## Local variables
#
dst=$HOME/.config/i3/config

## Backup and link i3 config
#
bck_cfg_and_link $dst config

## Check if i3wsr is installed and add it to i3 config
#
cmd="i3wsr"
if command -v $cmd &>/dev/null; then
	add_i3_autostart $cmd "" $dst
fi

exit 0
