#!/usr/bin/env bash

source ./utils.sh
source ../utils.sh

## Local variables
#
dst=$HOME/.config/i3/config

## Backup and link i3 config
#
bck_cfg_and_link $dst config

## Check if i3wsr is installed and add it to i3 config
#
cmd="i3wsr"
if command -v $cmd &>/dev/null; then
	add_i3_autostart $cmd "" $dst
fi

## Check if rofi is installed and replace the default dmenu with rofi
#
cmd="rofi"
if command -v $cmd &>/dev/null; then
	set_i3_keybind "mod+d" "$cmd" "-show drun -style sidebar -show-icons -icon-theme \"numix\"" $dst
fi

## Check if autorandr is installed and add it to i3 config
#
cmd="autorandr"
if command -v $cmd &>/dev/null; then
	# Cycle through available display configurations
	set_i3_keybind "mod+p" "$cmd" "--cycle; nitrogen --restore" $dst
	# Switch to internal display
	set_i3_keybind "mod+Shift+p" "$cmd" "int; nitrogen --restore" $dst
	# Turn off display
	set_i3_keybind "mod+o" "$cmd" "off" $dst
fi

## Check if cinnamon-screensaver is installed and add it to i3 config
#
cmd="cinnamon-screensaver-command"
if command -v $cmd &>/dev/null; then
	# Lock screen
	set_i3_keybind "mod+l" "$cmd" "-l" $dst
	# Lock screen and turn off the display
	set_i3_keybind "mod+Shift+l" "$cmd" "-l; xset dpms force off" $dst
fi

## Check if brightnessctl is installed and add it to i3 config
#
cmd="brightnessctl"
if command -v $cmd &>/dev/null; then
	# Increase brightness
	set_i3_keybind "XF86MonBrightnessUp" "$cmd" "set +10%" $dst
	# Decrease brightness
	set_i3_keybind "XF86MonBrightnessDown" "$cmd" "set 10%-" $dst
fi

exit 0
