#!/usr/bin/env sh
sketchybar --clone     cpu.label          label_template                                \
           --set       cpu.label          associated_space=1                            \
                                          label=cpu                                     \
                                          position=left                                \
                                          drawing=on                                    \
           --add       item               cpu.separator left                           \
           --set       cpu.separator      icon.drawing=off                              \
                                          label.drawing=off                             \
                                          background.padding_left=0                     \
                                          background.padding_right=0                    \
                                          associated_space=1                            \
                                                                                        \
           --add       item               cpu.topproc left                             \
           --set       cpu.topproc        label.font="$FONT:Semibold:7"                 \
                                          label=CPU                                     \
                                          icon.drawing=off                              \
                                          width=0                                       \
                                          y_offset=6                                    \
                                          associated_space=1                            \
                                          update_freq=5                                 \
                                          script="$PLUGIN_DIR/topproc.sh"               \
                                                                                        \
           --add       item               cpu.percent left                             \
           --set       cpu.percent        label.font="$FONT:Heavy:12"                   \
                                          label=CPU                                     \
                                          y_offset=-4                                   \
                                          width=40                                      \
                                          icon.drawing=off                              \
                                          update_freq=2                                 \
                                          associated_space=1                            \
                                                                                        \
           --add       graph              cpu.user left 100                            \
           --set       cpu.user           graph.color=0xffe1e3e4                        \
                                          update_freq=2                                 \
                                          width=0                                       \
                                          associated_space=1                            \
                                          label.drawing=off                             \
                                          icon.drawing=off                              \
                                          background.height=23                          \
                                          background.color=0x00000000                   \
                                          background.border_color=0x00000000            \
                                          script="$PLUGIN_DIR/cpu.sh"                   \
                                                                                        \
           --add       graph              cpu.sys left 100                             \
           --set       cpu.sys            associated_space=1                            \
                                          graph.color=0xff9dd274                        \
                                          label.drawing=off                             \
                                          icon.drawing=off                              \
                                          background.height=23                          \
                                          background.color=0x00000000                   \
                                          background.border_color=0x00000000            \
                                                                                        \
           --add       bracket            cpu                                           \
                                          cpu.separator                                 \
                                          cpu.topproc                                   \
                                          cpu.percent                                   \
                                          cpu.user                                      \
                                          cpu.sys                                       \
                                          cpu.label                                     \
                                                                                        \
           --set       cpu                background.drawing=on
