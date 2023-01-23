#!/bin/bash

strip_prefix() {
    arg=$1

    [[ ${arg::1} -eq 0 ]] && echo ${arg:1:1} || echo $arg
}

is_summer() {
    [[ $MONTH -ge 3 && $MONTH -le 8 ]] && echo y || echo n
}

MIN_LEVEL=30
MAX_LEVEL=60

MONTH=$(date +'%m')
HOUR=$(date +'%H')
MINUTE=$(date +'%M')

MONTH=$(strip_prefix $MONTH)
MINUTE=$(strip_prefix $MINUTE)
HOUR=$(strip_prefix $HOUR)

echo "Month: $MONTH, Hour: $HOUR, Minute: $MINUTE, Summer: $(is_summer)"

if [[ $(is_summer) == "y" ]]; then

    if [[ $HOUR -ge 18 ]]; then
        LEVEL=$MIN_LEVEL
    else
        LEVEL=$MAX_LEVEL
    fi

else

    if [[ $HOUR -ge 18 ]]; then

        LEVEL=$MIN_LEVEL

    elif [[ $HOUR -ge 17 ]]; then

        if [[ $MINUTE -ge 30 ]]; then
            LEVEL=40
        else
            LEVEL=50
        fi

    else
        LEVEL=$MAX_LEVEL
    fi

fi

echo "Adjusting screen brightness..."

light -S $LEVEL
