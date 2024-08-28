#!/usr/bin/env bash

#Set current time variables
theString=""
wantFuzz=$(<~/Dropbox/.lkconfig/fuzzy.txt)

if [ "$wantFuzz" == 0 ];
then
    currHour=$(($(date '+%-I') % 12))
    minute_phrase[0]=" o'clock"
    minute_phrase[1]="Five past "
    minute_phrase[2]="Ten past "
    minute_phrase[3]="Quarter past "
    minute_phrase[4]="Twenty past "
    minute_phrase[5]="Twenty-five past "
    minute_phrase[6]="Half past "
    minute_phrase[7]="Twenty-five til "
    minute_phrase[8]="Twenty til "
    minute_phrase[9]="Quarter til "
    minute_phrase[10]="Ten til "
    minute_phrase[11]="Five til "
    hour_phrase[0]="Twelve"
    hour_phrase[1]="One"
    hour_phrase[2]="Two"
    hour_phrase[3]="Three"
    hour_phrase[4]="Four"
    hour_phrase[5]="Five"
    hour_phrase[6]="Six"
    hour_phrase[7]="Seven"
    hour_phrase[8]="Eight"
    hour_phrase[9]="Nine"
    hour_phrase[10]="Ten"
    hour_phrase[11]="Eleven"
    #Handle the rounding of the time
    roundedMinute=$((((($(date '+%-M') +2) / 5)*5)%60))
    exactMinute=$(date '+%-M')
    minuteIndex=$((roundedMinute / 5))
    # Increase currHour by 1 if the index is >= 7
    # The second clause is could have an off-by-one error. Come back and change it if its wrong
    if [ $minuteIndex -ge 7 ] || [ $exactMinute -ge 58 ];
    then
        currHour=$(((currHour + 1) % 12))
    fi
    # Now we create theString using the arrays, but we need a special case if the index is 0
    if [ $minuteIndex == 0 ];
    then
        theString=${hour_phrase[$currHour]}
        theString+=${minute_phrase[$minuteIndex]}
    else
        theString=${minute_phrase[$minuteIndex]}
        theString+=${hour_phrase[$currHour]}
    fi
    sketchybar --set $NAME label="$theString"
    sketchybar --set $NAME update_freq=120
else
    theString=$(date '+%I:%M')
    sketchybar --set $NAME label="$theString"
    sketchybar --set $NAME update_freq=30
fi
# Send shetchybar the string
