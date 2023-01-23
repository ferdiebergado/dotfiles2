#!/bin/bash

action=$(echo -e "LOCK\nLOGOUT\nREBOOT\nPOWEROFF" | bemenu -i -w --fn 'Misc Ohsnap' -H 22 --hb \#00ffff --hf \#000000 --tf \#00ffff -p '   EXIT:')

case "$action" in
    LOCK)
        swaylock.sh
        ;;
    LOGOUT) swaymsg exit
        ;;
    REBOOT) reboot
        ;;
    POWEROFF) poweroff
        ;;
esac
