#!/bin/bash

update() {
    source "$HOME/.config/sketchybar/colors.sh"
    COLOR=$BACKGROUND_2
    if [ "$SELECTED" = "true" ]; then
        COLOR=$MAGENTA
    fi
    sketchybar --set $NAME icon.highlight=$SELECTED label.highlight="$SELECTED" background.border_color=$COLOR
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
