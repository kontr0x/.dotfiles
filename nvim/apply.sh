#!/usr/bin/env bash

## Local variables
#
dst=$HOME/.config/nvim

if [ ! -d $dst ]; then
    clone_git_repo https://github.com/kontr0x/my-kickstart.nvim.git $HOME/.config/nvim
fi

exit 0
