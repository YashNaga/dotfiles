#!/bin/bash

apple_logo=(
  icon=$APPLE
  icon.font="$FONT:Black:20.0"
  icon.color=$MAGENTA
  padding_right=15
  background.height=0
  icon.y_offset=3
  label.drawing=off
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
