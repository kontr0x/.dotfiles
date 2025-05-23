#!/usr/bin/env bash

source ../utils.sh

## Local variables
#
dir=$HOME # The destination directory
cfg=.non-existing-rc # The config file name

## Ensure the destination directory exists
#
mkdir -p $dir

## Backup and link config
#
bck_cfg_and_link $dir/$cfg $cfg

exit 0

