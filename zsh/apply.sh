#!/bin/bash

dst=$HOME/.zshrc

if [ -f $dst ]; then
	if [ ! -L "${dst}" ]; then
		mv $dst "${dst}_bck_`date +%s`"
	fi
	ln -fs $(pwd)/zshrc $dst
else
	exit 1
fi

exit 0
