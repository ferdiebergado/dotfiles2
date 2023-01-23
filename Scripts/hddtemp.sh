#!/bin/sh
ICON="thermometer"

TEMP=$(nc 127.0.0.1 7634 | awk -F '|' '{print $4}')

THRESH_GOOD=40
THRESH_WARN=50
THRESH_CRIT=60

STATE=

if [ $TEMP -lt $THRESH_GOOD ]; then
    STATE=Good
elif [ $TEMP -ge $THRESH_GOOD ] && [ $TEMP -le $THRESH_WARN ]; then
    STATE=Idle
elif [ $TEMP -ge $THRESH_WARN ] && [ $TEMP -le $THRESH_CRIT ]; then
    STATE=Warning
elif [[ $TEMP -gt $THRESH_CRIT ]]; then
    STATE=Critical
fi

echo -e "{\"icon\": \"$ICON\", \"text\": \" $TEMP°C\", \"state\": \"$STATE\"}"
