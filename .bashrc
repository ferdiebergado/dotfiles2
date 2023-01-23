#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# get start time
# start_time="$(date -u +%s.%N)"

# . /usr/share/blesh/ble.sh --noattach

### CONFIG ###

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# Auto "cd" when entering just a path
shopt -s autocd

# Enable vi mode
set -o vi

### ENVIRONMENT VARIABLES ###

# set the terminal
export TERM=xterm-256color

# Don't put duplicate lines in the history. See bash(1) for more options
# and ignore commands that start with a space
export HISTCONTROL=ignoredups:ignorespace

# avoid saving commands that start with a space
#export HISTCONTROL=ignorespace

# add timestamp to history
export HISTTIMEFORMAT="%F %T "

# add GPG key
export GPG_TTY=$(tty)

# fzf
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# load terminal color variables
. ~/Scripts/include/term_colors

### ALIASES ###
. ~/.bash_aliases

### KEY BINDINGS ###

# history completion
bind '"\e[A": history-substring-search-backward'
bind '"\e[B": history-substring-search-forward'

### FUNCTIONS ###
. ~/.bash_functions

### PLUGINS ###
. ~/.bash_plugins

### MAIN ###

# set the current command as the window title
trap 'echo -ne "\033]0;${BASH_COMMAND%% *}\007"' DEBUG

# If we're disconnected, capture whatever is in history
trap 'history -a' SIGHUP

update_title() {
    if [[ -n "$BASH_COMMAND" ]]; then
        echo -en "\033]0;"$(basename "${PWD}")"\007"
    fi
}

# set the prompt command
export PROMPT_COMMAND='update_title'

# set the command prompt
export PS1='\[${cyan}\]\w\[${normal}${yellow}\]$(__git_ps1 "  %s")\[${normal}\] \$ '

# show kernel info
uname -sr

# show startup time
# end_time="$(date -u +%s.%N)"
# elapsed="$(bc <<<"scale=3;sec=$end_time-$start_time;ms=sec*1000;ms")"
# printf "%.3f ms\n" $elapsed

# [[ ${BLE_VERSION-} ]] && ble-attach
