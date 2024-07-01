#!/usr/bin/env bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

if [ ! -d "./.git" ]; then
	echo "ERROR: Not inside a git repository"
	exit 1
fi

if [[ "`git rev-parse --show-toplevel`" != *".dotfiles" ]]; then
	echo "ERROR: Not inside the correct git repository"
	exit 1
fi

if [[ "`git rev-parse --show-toplevel`" != "`pwd`" ]]; then
	echo "ERROR: install.sh not called inside the git repository"
	exit 1
fi

function apply_conf () {
	if command -v $1 &>/dev/null; then
		echo -e "[${GREEN}+${ENDCOLOR}] $1"
		cd $HOME/.dotfiles/$1
		./apply.sh || echo -e "[${RED}-${ENDCOLOR}] $1"
		cd ..
	fi
}

directories=(`ls -l | grep '^d' | awk '{print $9}'`)
for cmd in "${directories[@]}"; do
	apply_conf $cmd
done
