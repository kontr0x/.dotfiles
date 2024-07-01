#!/usr/bin/env bash

# Backup and link zshrc
dst=$HOME/.zshrc
if [ -f $dst ]; then
	if [ ! -L "${dst}" ]; then
		mv $dst "${dst}_bck_`date +%s`"
	fi
	ln -fs $(pwd)/zshrc $dst
else
	exit 1
fi

# Check if oh-my-zsh is installed, otherwise install it
if [ ! -d $HOME/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check if fzf is installed and install fzf plugin
dst=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
if command -v fzf &>/dev/null; then
	if [ ! -d $dst ]; then
		git clone --quiet --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git $dst
	fi
	sed -i -E 's/plugins=\(([a-zA-Z ]*)\)/plugins=(\1 fzf)/g' $HOME/.zshrc
fi

exit 0
