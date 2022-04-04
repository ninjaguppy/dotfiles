#!/usr/bin/env sh

sketchybar --add       item               apple.logo left                                                \
           --set       apple.logo         icon=􀣺                                                         \
                                          icon.padding_right=6               \
                                          icon.padding_left=2                \
                                          background.padding_left=2          \
                                          background.padding_right=2         \
                                          icon.background.height=2           \
                                          icon.font="$FONT:Black:16.0"                                   \
                                          icon.color=0xff9dd274                                          \
                                          label.drawing=off                                              \
                                          click_script="sketchybar -m --set \$NAME popup.drawing=toggle popup.y_offset=30" \
                                                                                                         \
           --add       item               apple.preferences popup.apple.logo                             \
           --set       apple.preferences  icon=􀺽                                                         \
                                          label="Preferences"                                            \
                                          click_script="open -a 'System Preferences';                    
                                                        sketchybar -m --set apple.logo popup.drawing=off"\
           --add       item               apple.activity popup.apple.logo                                \
           --set       apple.activity     icon=􀒓                                                         \
                                          label="Activity"                                               \
                                          click_script="open -a 'Activity Monitor';                       
                                                        sketchybar -m --set apple.logo popup.drawing=off"\
           --add       item               apple.lock popup.apple.logo                                    \
           --set       apple.lock         icon=􀒳                                                         \
                                          label="Lock Screen"                                            \
                                          click_script="pmset displaysleepnow;                           
                                                        sketchybar -m --set apple.logo popup.drawing=off"
