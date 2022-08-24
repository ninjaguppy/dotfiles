#!/usr/bin/env bash

sketchybar    --add       item               yabai_mode left                                                     \
              --set       yabai_mode         update_freq=3                                                       \
                                             drawing=on                                                          \
                                             icon.padding_right=6               \
                                             icon.padding_left=2                \
                                             background.padding_left=2          \
                                             background.padding_right=2         \
                                             icon.background.height=2           \
                                             script="~/.config/sketchybar/plugins/yabai_mode.sh"                 \
                                             click_script="~/.config/sketchybar/plugins/yabai_mode_click.sh"     \
              --subscribe yabai_mode         space_change                                                        \
                                                                                                                 \
              --add       item               system.yabai left                                                   \
              --set       system.yabai       script="$PLUGIN_DIR/yabai.sh"                                       \
                                             icon.font="$FONT:Bold:16.0"                                         \
                                             icon.padding_right=6               \
                                             icon.padding_left=2                \
                                             background.padding_left=2          \
                                             background.padding_right=2         \
                                             icon.background.height=2           \
                                             label.drawing=off                                                   \
                                             width=30                                                            \
                                             align=center                                                        \
                                             updates=on                                                          \
              --subscribe system.yabai       window_focus monocle mouse.clicked                                  \
