#!/usr/bin/env sh

sketchybar --add       space              space_template left                \
           --set       space_template     icon.highlight_color=0xff9dd274    \
                                          label.drawing=off                  \
                                          drawing=off                        \
                                          updates=on                         \
                                          associated_display=1               \
                                          label.font="$FONT:Black:13.0"      \
                                          icon.font="$FONT:Bold:17.0"        \
                                          script="$PLUGIN_DIR/space.sh"      \
                                          icon.padding_right=6               \
                                          icon.padding_left=2                \
                                          background.padding_left=2          \
                                          background.padding_right=2         \
                                          icon.background.height=2           \
                                          icon.background.color=$ICON_COLOR  \
                                          icon.background.y_offset=-12       \
                                          click_script="$SPACE_CLICK_SCRIPT" \
                                                                             \
           --clone     spaces_1.label     label_template                     \
           --set       spaces_1.label     label=spc                          \
                                          label.width=55                     \
                                          label.align=center                 \
                                          associated_display=1               \
                                          position=left                      \
                                          drawing=on                         \
                                                                             \
           --clone      comms             space_template                     \
           --set        comms             associated_space=1                 \
                                          icon=􀬄                            \
                                          icon.highlight_color=0xfffd6883    \
                                          icon.background.color=0xfffd6883   \
                                          drawing=on                         \
                                                                             \
           --clone     code               space_template                     \
           --set       code               associated_space=2                 \
                                          icon=􀤙                            \
                                          icon.highlight_color=0xffadda78    \
                                          icon.background.color=0xffadda78   \
                                          drawing=on                         \
                                                                             \
           --clone     web                space_template                     \
           --set       web                associated_space=3                 \
                                          icon=􀤆                            \
                                          icon.highlight_color=0xfff9cc6c    \
                                          icon.background.color=0xfff9cc6c   \
                                          drawing=on                         \
                                                                             \
           --clone     todo               space_template                     \
           --set       todo               associated_space=4                 \
                                          icon=􀃳                            \
                                          icon.highlight_color=0xfff38d70    \
                                          icon.background.color=0xfff38d70   \
                                          drawing=on                         \
                                                                             \
           --clone     idle               space_template                     \
           --set       idle               associated_space=5                 \
                                          icon=􀓕                            \
                                          icon.highlight_color=0xffa8a9eb    \
                                          icon.background.color=0xffa8a9eb   \
                                          drawing=on                         \
                                                                             \
           --clone     music              space_template                     \
           --set       music              associated_space=6                 \
                                          icon=􀽍                            \
                                          icon.highlight_color=0xff85dacc    \
                                          icon.background.color=0xff85dacc   \
                                          drawing=on                         \
                                                                             \
           --add       bracket            spaces_1                           \
                                          spaces_1.label                     \
                                          comms                               \
                                          code                               \
                                          web                                \
                                          todo                               \
                                          idle                               \
                                          music                              \
                                                                             \
           --set       spaces_1           background.drawing=on              \
