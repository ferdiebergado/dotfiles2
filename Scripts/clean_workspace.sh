#!/bin/bash

clean() {
    fd -t d -H "$1" "$2" -X rm -rfv
}

ws="$HOME/Workspace"
pydir="$ws/python"
jsdir="$ws/javascript"

clean ".venv" "$pydir"
clean "__pycache__" "$pydir"
clean "node_modules" "$jsdir"
