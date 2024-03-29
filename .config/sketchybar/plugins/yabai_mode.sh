#!/usr/bin/env bash

yabai_mode=$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')
case "$yabai_mode" in
    bsp)
    sketchybar -m --set yabai_mode label="􀏝"
    ;;
    stack)
    sketchybar -m --set yabai_mode label="􀯱"
    ;;
    float)
    sketchybar -m --set yabai_mode label="􀏧"
    ;;
esac
