#!/usr/bin/env bash

yabai_mode=$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')

case "$yabai_mode" in
    bsp)
    yabai -m config layout stack && sketchybar -m --set yabai_mode label="ôŻą"
    ;;
    stack)
    yabai -m config layout float && sketchybar -m --set yabai_mode label="ô§"
    ;;
    float)
    yabai -m config layout bsp && sketchybar -m --set yabai_mode label="ô"
    ;;
esac
