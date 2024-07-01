#!/bin/bash

# Backup and link i3 config
dst=$HOME/.config/i3/config
if [ -f $dst ]; then
	if [ ! -L "${dst}" ]; then
		mv $dst "${dst}_bck_`date +%s`"
	fi
	ln -fs $(pwd)/config $dst
else
	exit 1
fi

exit 0
