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
	if ! grep -q -E 'exec_always --no-startup-id [a-zA-Z0-9\_\.\/\-]+/i3wsr' $dst; then
		echo -e "# Start i3wsr\nexec_always --no-startup-id $(which i3wsr)" >> $dst
	fi
fi

exit 0
