#!/usr/bin/env bash

source ../utils.sh

## Local variables
#
dst=$HOME/.zshrc

## Helper functions
#
function __install_omz_plugin() {
	git_repo=$1
	plugin_name=$(sed -E 's/.*\/([a-zA-Z\-]+)\.git/\1/g' <<< $git_repo)
	dst=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name
	if [ ! -d $dst ]; then
		clone_git_repo $git_repo $dst
	fi
	if ! grep -q -E 'plugins=\((.*'$plugin_name'.*)\)' ~/.zshrc; then
		sed -i --follow-symlinks -E 's/plugins=\(([a-zA-Z \-]*)\)/plugins=(\1 '$plugin_name')/g' ~/.zshrc
	fi
}

## Backup and link zshrc
#
bck_cfg_and_link $dst zshrc

## Check if gnome-keyring is installed and add it to zshrc
#
cmd="gnome-keyring-daemon"
if command -v $cmd &>/dev/null; then
	# Keyring fix
	replace_or_append "export SSH_AGENT_PID" "export SSH_AGENT_PID=\$(pidof ssh-agent)" $dst  
	replace_or_append "export SSH_AUTH_SOCK" "export SSH_AUTH_SOCK=\$(find /tmp -path '*/ssh-*' -name 'agent.*' -user $USER -print -quit 2>/dev/null)" $dst
	replace_or_append "export GNOME_KEYRING_CONTROL" "export GNOME_KEYRING_CONTROL=\$(find /run/user/$(id -u) -name '*keyring*' -print -quit 2>/dev/null)" $dst
fi

## Check if neovim is installed and replace the local editor with neovim
#
cmd="nvim"
if command -v $cmd &>/dev/null; then
	replace_or_append "export EDITOR='vim' # Local" "export EDITOR='$cmd' # Local" $dst
fi

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
