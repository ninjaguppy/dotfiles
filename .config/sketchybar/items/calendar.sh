#!/bin/bash

calendar=(
  icon=cal
  icon.font="$FONT:Black:12.0"
  icon.padding_right=0
  label.width=0
  label.align=left
  background.padding_right=10                    \
  padding_left=3
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)
fuzzytime=(
  icon.padding_right=2
  label.align=left
  label.padding_right=2
  background.padding_right=0
  background.padding_left=0
  update_freq=1
  script="$PLUGIN_DIR/fuzzytime.bash"
)

sketchybar --add item fuzzytime right       \
           --set fuzzytime "${fuzzytime[@]}" \
           --subscribe fuzzytime timechange \
           --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke\
