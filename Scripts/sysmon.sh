#!/bin/bash

term='xterm-256color'
font='Misc Ohsnap:size=10'
appid=sysmon

swaymsg workspace number 10 && foot -a $appid -t "$term" -f "$font" -T htop htop &
swaymsg splitv && foot -a $appid -t "$term" -f "$font" -T 'journalctl -f' journalctl -f &
swaymsg focus up
