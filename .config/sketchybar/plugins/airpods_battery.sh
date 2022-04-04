#!/usr/bin/env bash

DEVICES=$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq -rc '.SPBluetoothDataType[0].devices_list[]? | select( .[] | .device_minorType == "Headphones" and .device_connected =="Yes") | keys[]')
if [ "$DEVICES" = "" ]; then
  sketchybar -m --set $NAME drawing=on label="NoConnection"
else
  sketchybar -m --set $NAME drawing=on
  # Left
  LEFT="$(defaults read /Library/Preferences/com.apple.Bluetooth | grep BatteryPercentLeft | tr -d \; | awk '{print $3}')"

  # Right
  RIGHT="$(defaults read /Library/Preferences/com.apple.Bluetooth | grep BatteryPercentRight | tr -d \; | awk '{print $3}')"

  # Case
  CASE="$(defaults read /Library/Preferences/com.apple.Bluetooth | grep BatteryPercentCase | tr -d \; | awk '{print $3}')"

  if [ $LEFT = 0 ]; then
    LEFT="-"
  fi

  if [ $RIGHT = 0 ]; then
    RIGHT="-"
  fi

  if [ $CASE -eq 0 ]; then
    CASE="-"
  fi

  sketchybar -m --set $NAME label="$LEFT $CASE $RIGHT"
  echo "$LEFT $CASE $RIGHT"
fi
