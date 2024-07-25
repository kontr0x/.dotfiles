#!/usr/bin/env bash

source ../utils.sh

## Helper functions
#
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

## Backup and link zshrc
#
bck_cfg_and_link $HOME/.zshrc zshrc

## Setup oh-my-zsh
#
# Check if oh-my-zsh is installed, otherwise install it
if [ ! -d $HOME/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
#
# Install oh-my-zsh plugins
__install_omz_plugin https://github.com/unixorn/fzf-zsh-plugin.git
__install_omz_plugin https://github.com/zsh-users/zsh-autosuggestions.git

exit 0
