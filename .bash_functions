# vim:ft=sh 

# colored man pages
man() {
    LESS_TERMCAP_mb=$'\e[01;31m'
    LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[45;93m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[4;93m'

    command man "$@"
}

# Change working dir in shell to last dir in lf on exit (adapted from ranger).
lfcd() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Show the cheatsheet for a specified command
cht() {
    local cs="$HOME/Scripts/cheatsheets/$1"

    [[ ! -f $cs ]] && curl -sS cheat.sh/$1 -o "$cs"

    less "$cs"
}

# Show a clock on the top right corner of the terminal
clock() {
    while sleep 1; do
        tput sc
        tput cup 0 $(($(tput cols) - 29))
        date
        tput rc
    done &
}

# most used commands
comtop() {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# finds duplicate files
finddup() {
    find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
}

# quick calculator (usage: ? 10*2+3)
calc() { echo "$*" | bc -l; }

# unlock pdf (usage: unlock input.pdf output.pdf)
unlockpdf() {
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$2" -c .setpdfwrite -f "$1"
}

# download all comma-separated file types from a website (ex. dl url pdf,zip)
dl() {
    wget --reject html,htm --accept "$2" -rl1 "$1"
}

# check shortened url
chkurl() { curl -sI $1 | sed -n 's/Location: *//p'; }

# view manual for a switch of a particular command (ex: manswitch curl -s)
manswitch() { man $1 | less -p "^ +$2"; }

# grab the IP address of a running container (usage: dockip <container-name or id>)
dockip() {
    docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}

# Reload the shell
reload() {
    exec "${SHELL}" "$@"
}

ze() {
    local f="$(fd --strip-cwd-prefix --hidden --follow --exclude ".git" | fzf)"

    [[ ${#f} != 0 ]] || return 0

    e "$f"
}

zd() {
    local d="$(fd --type d --hidden --follow --exclude ".git" | fzf)"

    [[ ${#d} != 0 ]] || return 0

    cd "$d"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
    if [ ! "$#" -gt 0 ]; then
        echo "Need a string to search for!"
        return 1
    fi
    rg -i -l --hidden --no-ignore-vcs --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

