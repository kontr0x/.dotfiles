#!/usr/bin/env bash

function __install_omz_plugin() {
	git_repo=$1
	plugin_name=$(sed -E 's/.*\/([a-zA-Z\-]+)\.git/\1/g' <<< $git_repo)
	dst=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name
	if [ ! -d $dst ]; then
		git clone --quiet --depth 1 $git_repo $dst
	fi
	if ! grep -q -E 'plugins=\((.*'$plugin_name'.*)\)' ~/.zshrc; then
		sed -i --follow-symlinks -E 's/plugins=\(([a-zA-Z \-]*)\)/plugins=(\1 '$plugin_name')/g' ~/.zshrc
	fi
}

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

__install_omz_plugin https://github.com/unixorn/fzf-zsh-plugin.git
__install_omz_plugin https://github.com/zsh-users/zsh-autosuggestions.git

exit 0
