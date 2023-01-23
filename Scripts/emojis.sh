#!/bin/bash

emojis="$HOME/emojis.txt"

[[ ! -f $emojis ]] && curl -sSL 'https://git.io/JXXO7' -o $emojis

emoji="$(cat $emojis | fzf)"

[[ ${#emoji} != 0 ]] || exit 0

echo "$emoji" | awk '{print $1}' | wl-copy --trim-newline
