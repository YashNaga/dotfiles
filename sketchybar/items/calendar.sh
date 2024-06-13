#!/bin/bash

calendar=(
	icon=cal
	icon.font="$FONT:Black:12.0"
    label.font="$FONT:Black:12.0"
	icon.padding_right=10
	label.width=60 #45
	label.align=right
    icon.y_offset=1
    label.y_offset=1
	padding_left=10
	padding_right=5
	update_freq=30
	script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
