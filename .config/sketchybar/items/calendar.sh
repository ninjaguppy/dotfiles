#!/usr/bin/env sh

sketchybar --add       item               messages right                                \
           --set       messages           update_freq=10                                \
                                          script="$PLUGIN_DIR/messages.sh"              \
                                          drawing=on                                    \
                                                                                        \
#          #--add       item               mailIndicator right
#          #--set       mailIndicator      update_freq=30                                \
#          #                               script="$PLUGIN_DIR/mailIndicator.sh"         \
#          #                               icon.font="$FONT:Bold:16.0"                   \
#          #                               icon=􀍜                                       \
#          #                               label.padding_right=8                         \
#          #                               background.padding_right=0                    \
#          #                               label=!                                       \
#          #                                                                             \
#          #--add       event              bluetooth_change "com.apple.bluetooth.status" \
#          #--add       item               headphones right                              \
#          #--set       headphones         icon=􀪷                                       \
#          #                              script="$PLUGIN_DIR/airpods_battery.sh"       \
#          #--subscribe headphones         bluetooth_change                              \
#          #                                                                            \
sketchybar --add       alias              MeetingBar right                              \
           --set       MeetingBar         background.padding_right=-8                   \
                                          background.padding_left=-6                    \
                                          update_freq=10                                \
                                                                                        \
           --clone     fuzztime           label_template                                 \
           --set       fuzztime           position=right                                \
                                          update_freq=45                                 \
                                          label.font="$FONT:Semibold:13.0"              \
                                          label=test                                     \
                                          drawing=on                                    \
                                          background.padding_right=0                    \
                                          background.padding_left=-2                    \
                                          script="$PLUGIN_DIR/fuzzytime.bash"             \
#      #    --add       item               calendar.time right
#      #    --set       calendar.time      update_freq=15                                \
#      #                                   icon.drawing=off                              \
#      #                                   script="$PLUGIN_DIR/time.sh"                  \
sketchybar --clone     calendar.date      label_template                                \
           --set       calendar.date      update_freq=60                                \
                                          position=right                                \
                                          label.font="$FONT:Semibold:13.0"              \
                                          label=cal                                     \
                                          drawing=on                                    \
                                          background.padding_right=0                    \
                                          script="$PLUGIN_DIR/date.sh"                  \
                                                                                        \
                                                                                       \
           --add       bracket            calendar                                      \
                                          messages                                      \
                                          MeetingBar                                    \
                                          calendar.date                                 \
                                                                                        \
           --set       calendar           background.drawing=on
