#!/usr/bin/env bash

# Backup and link tmux.conf
dst=$HOME/.tmux.conf
if [ -f $dst ]; then
	if [ ! -L "${dst}" ]; then
		mv $dst "${dst}_bck_`date +%s`"
	fi
	ln -fs $(pwd)/tmux.conf $dst
else
	exit 1
fi

exit 0
