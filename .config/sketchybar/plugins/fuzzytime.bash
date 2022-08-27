#!/usr/bin/env bash

#Set current time variables
currHour=$(($(date '+%-I') % 12))
currMinute=$(date '+%-M')

theString=""

minute_phrase[0]=" o'clock"
minute_phrase[1]="five past "
minute_phrase[2]="ten past "
minute_phrase[3]="quarter past "
minute_phrase[4]="twenty past "
minute_phrase[5]="twenty-five past "
minute_phrase[6]="half past "
minute_phrase[7]="twenty-five til "
minute_phrase[8]="twenty til "
minute_phrase[9]="quarter til "
minute_phrase[10]="ten til "
minute_phrase[11]="five til "

hour_phrase[0]="twelve"
hour_phrase[1]="one"
hour_phrase[2]="two"
hour_phrase[3]="three"
hour_phrase[4]="four"
hour_phrase[5]="five"
hour_phrase[6]="six"
hour_phrase[7]="seven"
hour_phrase[8]="eight"
hour_phrase[9]="nine"
hour_phrase[10]="ten"
hour_phrase[11]="eleven"

#Handle the rounding of the time
roundedMinute=$((((($(date '+%M') +2) / 5)*5)%60))
minuteIndex=$(($roundedMinute / 5))

# Increase currHour by 1 if the index is >= 7
if [ $minuteIndex -ge 7 ];
then
    currHour=$((($currHour + 1) % 12))
fi

# Now we create theString using the arrays, but we need a special case if the index is 0
if [ $minuteIndex -eq 0 ];
then
    theString=${hour_phrase[$currHour]}
    theString+=${minute_phrase[$minuteIndex]}
else
    theString=${minute_phrase[$minuteIndex]}
    theString+=${hour_phrase[$currHour]}
fi

# Send shetchybar the string
sketchybar --set $NAME label="$theString"
