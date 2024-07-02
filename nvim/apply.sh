#!/usr/bin/env bash

dst=$HOME/.config/nvim
if [ ! -d $dst ]; then
    git clone --quiet https://github.com/kontr0x/my-kickstart.nvim.git $HOME/.config/nvim
fi

exit 0
