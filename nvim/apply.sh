#!/usr/bin/env bash

source ../utils.sh

## Local variables
#
dst=$HOME/.config/nvim

if [ ! -d $dst ]; then
    clone_git_repo https://github.com/kontr0x/my-kickstart.nvim.git $HOME/.config/nvim
fi

## Install Hasklig Nerd Font
#
nerd_font_base_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"
nerd_font="Hasklig"
#
wget -q -O /tmp/${nerd_font}.zip ${nerd_font_base_url}${nerd_font}.zip
if [ $? -ne 0 ]; then
	negative "> Failed to download nerd font ${nerd_font}.zip"
fi
#
unzip -o /tmp/${nerd_font}.zip -d $HOME/.fonts "*.otf"
if [ $? -ne 0 ]; then
	negative "> Failed to unzip nerd font ${nerd_font}.zip"
fi

fc-cache -fv $HOME/.fonts
positive "> Successfully installed ${nerd_font} Nerd Font"

exit 0
