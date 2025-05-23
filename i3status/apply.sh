#!/usr/bin/env bash

source ../utils.sh

## Local variables
#
dir=$HOME/.config/i3status
cfg=config

## Ensure the destination directory exists
#
mkdir -p $dir

## Backup and link config
#
bck_cfg_and_link $dir/$cfg $cfg

exit 0

