#!/usr/bin/env bash

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

if command -v i3wsr $>/dev/null; then
	echo "# Start i3wsr\nexec_always --no-startup-id $(which i3wsr)" | tee -a $dst
fi

exit 0
