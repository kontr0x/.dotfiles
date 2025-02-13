#!/usr/bin/env bash

source ../utils.sh

function replace_or_append() {
	match=$1
	debug "match: $match"
	replace=$2
	debug "replace: $replace"
	file_path=$3
	debug "file_path: $file_path"
	grep_match=$(grep "${match}" $file_path | sed '/^#/d')
	if [[ -n "$grep_match" ]]; then
		if [[ $(echo "$grep_match" | wc -l) -eq 1 ]]; then
			sed -i --follow-symlinks "s/$grep_match/$replace/" $file_path
		fi
	else
		echo -e "$replace" | tee -a $file_path &>/dev/null
	fi
}

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
	new_i3_keybind="bindsym \$$keybind exec $cmd $cmd_args"
	replace_or_append "$keybind" "$new_i3_keybind" $config_path
	if [ $? -eq 0 ];then
		positive "> Bound keybind $keybind to $cmd"
	fi
}

