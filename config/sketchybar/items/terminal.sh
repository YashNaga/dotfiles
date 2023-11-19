#!/bin/bash

# its called github bell but it opens a terminal. if i change the name the bar breaks and idk why

github_bell=(
  icon.font="$FONT:ExtraBold:21.0"
  icon="≥"
  icon.color=$BLUE
  label.highlight_color=$BLUE
  click_script="open -n -a 'iTerm'; $POPUP_OFF"
)

sketchybar --add item github.bell right                 \
           --set github.bell "${github_bell[@]}"        \
