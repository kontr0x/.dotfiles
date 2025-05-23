#!/usr/bin/env bash

source ../utils.sh

## Helper functions
#
function add_i3_autostart() {
	cmd=$1
	cmd_args=$2
	config_path=$3
	new_i3_autostart="exec_always --no-startup-id $cmd $cmd_args"
	replace_or_append "exec_always --no-startup-id [\.\/\w\d]*${cmd}" "$new_i3_autostart" $config_path
	if [ $? -eq 0 ]; then
		positive "> $cmd"
	fi
}

function set_i3_keybind() {
	keybind=$1
	cmd=$2
	cmd_args=$3
	config_path=$4
	new_i3_keybind="bindsym $keybind exec $cmd $cmd_args"
	replace_or_append "$keybind" "$new_i3_keybind" $config_path
	if [ $? -eq 0 ];then
		positive "> Bound keybind $keybind to $cmd"
	fi
}

