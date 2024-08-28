#!/bin/bash

zen_on() {
  sketchybar --set github.bell drawing=off \
             --set apple.logo drawing=off \
             --set separator drawing=off \
             --set front_app drawing=off \
             --set volume_icon drawing=off \
}

zen_off() {
  sketchybar --set github.bell drawing=on \
             --set apple.logo drawing=on \
             --set '/cpu.*/' drawing=on \
             --set separator drawing=on \
             --set front_app drawing=on \
             --set volume_icon drawing=on \
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query apple.logo | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi

