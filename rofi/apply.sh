#!/usr/bin/env bash

source ../utils.sh

## Local variables
#
dir=$HOME/.config/rofi
cfg=config.rasi

## Ensure the destination directory exists
#
mkdir -p $dir

## Backup and link rofi config
#
bck_cfg_and_link $dir/$cfg $cfg

## Copy files to rofi directory
#
cp -r ./files/* $dir/

exit 0

